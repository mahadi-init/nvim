-- lua/tag-plugin/init.lua
local M = {}

-- Storage for tags (in-memory, persists during session)
local tags = {}
local ns_id = vim.api.nvim_create_namespace 'tag-plugin'

-- Configuration
local config = {
  highlight_group = 'TagHighlight',
  tag_symbol = '🏷️ ',
  fzf_opts = {
    prompt = 'Tags> ',
    preview_window = 'right:50%',
  },
  data_dir = vim.fn.stdpath 'data' .. '/tag-plugin',
}

-- Get project root directory
local function get_project_root()
  local cwd = vim.fn.getcwd()
  local git_root = vim.fn.system('git -C ' .. cwd .. ' rev-parse --show-toplevel 2>/dev/null')

  if vim.v.shell_error == 0 then
    return vim.trim(git_root)
  else
    return cwd
  end
end

-- Get project-specific tags file path
local function get_tags_file()
  local project_root = get_project_root()
  local project_name = vim.fn.fnamemodify(project_root, ':t')
  local project_hash = vim.fn.sha256(project_root)

  -- Create data directory if it doesn't exist
  vim.fn.mkdir(config.data_dir, 'p')

  return config.data_dir .. '/' .. project_name .. '_' .. project_hash:sub(1, 8) .. '.json'
end

-- Save tags to file
local function save_tags()
  local tags_file = get_tags_file()
  local serializable_tags = {}

  for tag_id, tag_info in pairs(tags) do
    serializable_tags[tag_id] = {
      tag_name = tag_info.tag_name,
      filepath = tag_info.filepath,
      line_nr = tag_info.line_nr,
      line_content = tag_info.line_content,
      timestamp = tag_info.timestamp,
    }
  end

  local json_str = vim.fn.json_encode(serializable_tags)
  local file = io.open(tags_file, 'w')
  if file then
    file:write(json_str)
    file:close()
  end
end

-- Load tags from file
local function load_tags()
  local tags_file = get_tags_file()
  local file = io.open(tags_file, 'r')

  if not file then
    return {}
  end

  local content = file:read '*all'
  file:close()

  if content and content ~= '' then
    local ok, decoded = pcall(vim.fn.json_decode, content)
    if ok and decoded then
      return decoded
    end
  end

  return {}
end

-- Restore virtual text for loaded tags
local function restore_virtual_text()
  for tag_id, tag_info in pairs(tags) do
    local bufnr = vim.fn.bufnr(tag_info.filepath)
    if bufnr ~= -1 then
      tag_info.bufnr = bufnr
      vim.api.nvim_buf_set_extmark(bufnr, ns_id, tag_info.line_nr - 1, 0, {
        virt_text = { { config.tag_symbol .. tag_info.tag_name, 'TagHighlight' } },
        virt_text_pos = 'eol',
        id = tag_info.line_nr,
      })
    end
  end
end

-- Create highlight group
vim.api.nvim_set_hl(0, 'TagHighlight', { bg = '#2a2a2a', fg = '#fbbf24' })

-- Helper function to get current buffer info
local function get_buffer_info()
  local bufnr = vim.api.nvim_get_current_buf()
  local filepath = vim.api.nvim_buf_get_name(bufnr)
  return bufnr, filepath
end

-- Helper function to get line content
local function get_line_content(bufnr, line_nr)
  local lines = vim.api.nvim_buf_get_lines(bufnr, line_nr - 1, line_nr, false)
  return lines[1] or ''
end

-- Add a tag to the current line
function M.add_tag(tag_name)
  if not tag_name or tag_name == '' then
    tag_name = vim.fn.input 'Tag name: '
    if tag_name == '' then
      return
    end
  end

  local bufnr, filepath = get_buffer_info()
  local line_nr = vim.api.nvim_win_get_cursor(0)[1]
  local line_content = get_line_content(bufnr, line_nr)

  -- Create unique tag ID
  local tag_id = filepath .. ':' .. line_nr

  -- Store tag info
  tags[tag_id] = {
    tag_name = tag_name,
    filepath = filepath,
    bufnr = bufnr,
    line_nr = line_nr,
    line_content = line_content,
    timestamp = os.time(),
  }

  -- Add virtual text to show the tag
  vim.api.nvim_buf_set_extmark(bufnr, ns_id, line_nr - 1, 0, {
    virt_text = { { config.tag_symbol .. tag_name, 'TagHighlight' } },
    virt_text_pos = 'eol',
    id = line_nr, -- Use line number as ID for easy removal
  })

  -- Save tags to file
  save_tags()

  print(' Tagged line ' .. line_nr .. " as '" .. tag_name .. "'")
end

-- Remove tag from current line
function M.remove_tag()
  local bufnr, filepath = get_buffer_info()
  local line_nr = vim.api.nvim_win_get_cursor(0)[1]
  local tag_id = filepath .. ':' .. line_nr

  if tags[tag_id] then
    tags[tag_id] = nil
    -- Remove virtual text
    vim.api.nvim_buf_del_extmark(bufnr, ns_id, line_nr)

    -- Save tags to file
    save_tags()

    print('Removed tag from line ' .. line_nr)
  else
    print 'No tag found on current line'
  end
end

-- Jump to a specific tag
local function jump_to_tag(tag_info)
  -- Check if buffer exists and is valid
  local bufnr = tag_info.bufnr
  if not bufnr or type(bufnr) ~= 'number' or not vim.api.nvim_buf_is_valid(bufnr) then
    -- Try to find existing buffer for this file
    bufnr = vim.fn.bufnr(tag_info.filepath)
    if bufnr == -1 then
      -- Open the file
      vim.cmd('edit ' .. vim.fn.fnameescape(tag_info.filepath))
      bufnr = vim.api.nvim_get_current_buf()
    else
      -- Switch to existing buffer
      vim.api.nvim_set_current_buf(bufnr)
    end
    -- Update the tag_info with correct buffer number
    tag_info.bufnr = bufnr
  else
    -- Switch to the buffer
    vim.api.nvim_set_current_buf(bufnr)
  end

  -- Jump to the line
  vim.api.nvim_win_set_cursor(0, { tag_info.line_nr, 0 })
  vim.cmd 'normal! zz' -- Center the line
end

-- Get all tags formatted for fzf
local function get_tags_for_fzf()
  local items = {}

  for tag_id, tag_info in pairs(tags) do
    local filename = vim.fn.fnamemodify(tag_info.filepath, ':t')
    local preview_line = tag_info.line_content:gsub('^%s+', '') -- Remove leading whitespace

    -- Format: "tag_name | filename:line_nr | preview"
    local display = string.format('%s | %s:%d | %s', tag_info.tag_name, filename, tag_info.line_nr, preview_line)

    table.insert(items, {
      display = display,
      tag_info = tag_info,
    })
  end

  return items
end

-- Show tags using fzf-lua
function M.show_tags()
  local fzf_lua = require 'fzf-lua'

  if vim.tbl_isempty(tags) then
    print 'No tags found'
    return
  end

  local items = get_tags_for_fzf()
  local display_items = {}

  for _, item in ipairs(items) do
    table.insert(display_items, item.display)
  end

  fzf_lua.fzf_exec(display_items, {
    prompt = config.fzf_opts.prompt,
    preview_window = config.fzf_opts.preview_window,
    actions = {
      ['default'] = function(selected)
        if selected and selected[1] then
          -- Find the corresponding tag_info
          for _, item in ipairs(items) do
            if item.display == selected[1] then
              jump_to_tag(item.tag_info)
              break
            end
          end
        end
      end,
      ['ctrl-d'] = function(selected)
        if selected and selected[1] then
          -- Delete selected tag
          for i, item in ipairs(items) do
            if item.display == selected[1] then
              local tag_id = item.tag_info.filepath .. ':' .. item.tag_info.line_nr
              tags[tag_id] = nil
              -- Remove virtual text
              if vim.api.nvim_buf_is_valid(item.tag_info.bufnr) then
                vim.api.nvim_buf_del_extmark(item.tag_info.bufnr, ns_id, item.tag_info.line_nr)
              end
              -- Save tags to file
              save_tags()
              print('Deleted tag: ' .. item.tag_info.tag_name)
              break
            end
          end
        end
      end,
    },
    previewer = function(selected)
      if selected and selected[1] then
        -- Find the corresponding tag_info
        for _, item in ipairs(items) do
          if item.display == selected[1] then
            -- Use fzf-lua's builtin file previewer for syntax highlighting
            return fzf_lua.path.file_or_uri(item.tag_info.filepath, {
              line = item.tag_info.line_nr,
              col = 1,
            })
          end
        end
      end
    end,
  })
end

-- List all tags in current buffer
function M.list_buffer_tags()
  local bufnr, filepath = get_buffer_info()
  local buffer_tags = {}

  for tag_id, tag_info in pairs(tags) do
    if tag_info.filepath == filepath then
      table.insert(buffer_tags, tag_info)
    end
  end

  if #buffer_tags == 0 then
    print 'No tags in current buffer'
    return
  end

  -- Sort by line number
  table.sort(buffer_tags, function(a, b)
    return a.line_nr < b.line_nr
  end)

  print 'Tags in current buffer:'
  for _, tag_info in ipairs(buffer_tags) do
    print(string.format('  Line %d: %s', tag_info.line_nr, tag_info.tag_name))
  end
end

-- Clear all tags
function M.clear_all_tags()
  local choice = vim.fn.confirm('Clear all tags?', '&Yes\n&No', 2)
  if choice == 1 then
    -- Clear virtual text from all buffers
    for _, tag_info in pairs(tags) do
      if vim.api.nvim_buf_is_valid(tag_info.bufnr) then
        vim.api.nvim_buf_del_extmark(tag_info.bufnr, ns_id, tag_info.line_nr)
      end
    end
    tags = {}
    -- Save empty tags to file
    save_tags()
    print 'All tags cleared'
  end
end

-- Setup function
function M.setup(opts)
  config = vim.tbl_deep_extend('force', config, opts or {})

  -- Load tags from file on startup
  tags = load_tags()

  -- Create autocommands for persistence and virtual text restoration
  local augroup = vim.api.nvim_create_augroup('TagPlugin', { clear = true })

  -- Save tags when exiting Neovim
  vim.api.nvim_create_autocmd('VimLeavePre', {
    group = augroup,
    callback = save_tags,
  })

  -- Restore virtual text when opening files
  vim.api.nvim_create_autocmd('BufReadPost', {
    group = augroup,
    callback = function()
      vim.defer_fn(restore_virtual_text, 100) -- Small delay to ensure buffer is ready
    end,
  })

  -- Also restore when switching buffers
  vim.api.nvim_create_autocmd('BufEnter', {
    group = augroup,
    callback = function()
      vim.defer_fn(restore_virtual_text, 10)
    end,
  })

  -- Create user commands
  vim.api.nvim_create_user_command('TagAdd', function(args)
    M.add_tag(args.args)
  end, { nargs = '?' })

  vim.api.nvim_create_user_command('TagRemove', M.remove_tag, {})
  vim.api.nvim_create_user_command('TagShow', M.show_tags, {})
  vim.api.nvim_create_user_command('TagList', M.list_buffer_tags, {})
  vim.api.nvim_create_user_command('TagClear', M.clear_all_tags, {})
end

return M
