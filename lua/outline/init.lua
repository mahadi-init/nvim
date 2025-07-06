local M = {}

-- Configuration
local config = {
  width = 45,
  position = 'right',
  auto_open = false,
  auto_close = false,
  patterns = {
    '{/%*%s*=>%s*(.-)%s*<%s*==%s*%*/}',
    '{/%*%s*(.-)%s*%*/}',
    '<!%-%-%s*=>%s*(.-)%s*<%s*==%s*%-%->',
    '<!%-%-%s*(.-)%s*%-%->',
  },
  tree_chars = {
    branch = '├─',
    last_branch = '└─',
    vertical = '│ ',
    leaf = '▶ ',
    folder = '📁',
    file = '📄',
  },
  highlights = {
    normal = 'HtmlOutlineNormal',
    cursor = 'HtmlOutlineCursor',
    title = 'HtmlOutlineTitle',
    separator = 'HtmlOutlineSeparator',
    branch = 'HtmlOutlineBranch',
    leaf = 'HtmlOutlineLeaf',
    line_number = 'HtmlOutlineLineNumber',
  },
}

local state = {
  buf = nil,
  win = nil,
  source_buf = nil,
  comments = {},
  is_open = false,
}

local function extract_comments(bufnr)
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local comments = {}
  for line_num, line in ipairs(lines) do
    for _, pattern in ipairs(config.patterns) do
      local match = string.match(line, pattern)
      if match then
        match = match:gsub('^%s*', ''):gsub('%s*$', '')
        table.insert(comments, {
          text = match,
          line = line_num,
          raw_line = line,
        })
        break
      end
    end
  end
  return comments
end

local function create_outline_content(comments)
  local content = {}
  if #comments == 0 then
    return { '', '   No HTML comments found', '' }
  end
  table.insert(content, '')
  table.insert(content, '  ' .. config.tree_chars.folder .. ' HTML Comments')
  table.insert(content, '')
  for i, comment in ipairs(comments) do
    local line_info = string.format('[%d]', comment.line)
    local text = #comment.text > 25 and comment.text:sub(1, 22) .. '...' or comment.text
    local is_last = i == #comments
    local branch_char = is_last and config.tree_chars.last_branch or config.tree_chars.branch
    table.insert(content, string.format('  %s %s %s %s', branch_char, config.tree_chars.leaf, line_info, text))
    if not is_last then
      table.insert(content, '  ' .. config.tree_chars.vertical)
    end
  end
  table.insert(content, '')
  return content
end

local function jump_to_comment(index)
  local comment = state.comments[index]
  if comment and vim.api.nvim_buf_is_valid(state.source_buf) then
    local win = vim.fn.bufwinid(state.source_buf)
    if win ~= -1 then
      vim.api.nvim_set_current_win(win)
      vim.api.nvim_win_set_cursor(win, { comment.line, 0 })
      vim.cmd 'normal! zz'
    end
  end
end

local function get_comment_index_from_line(line_num)
  if line_num <= 3 then
    return nil
  end
  local count = 0
  for i = 4, line_num do
    local l = vim.api.nvim_buf_get_lines(state.buf, i - 1, i, false)[1]
    if l and (l:match '├─' or l:match '└─') then
      count = count + 1
    end
  end
  return count > 0 and count or nil
end

local function setup_highlights()
  vim.api.nvim_set_hl(0, 'HtmlOutlineNormal', { fg = '#c0c0c0' })
  vim.api.nvim_set_hl(0, 'HtmlOutlineCursor', { fg = '#ffffff', bold = true })
  vim.api.nvim_set_hl(0, 'HtmlOutlineBorder', { fg = '#606060' })
  vim.api.nvim_set_hl(0, 'HtmlOutlineTitle', { fg = '#87ceeb', bold = true })
  vim.api.nvim_set_hl(0, 'HtmlOutlineBranch', { fg = '#87ceeb', bold = true })
  vim.api.nvim_set_hl(0, 'HtmlOutlineLeaf', { fg = '#90ee90' })
  vim.api.nvim_set_hl(0, 'HtmlOutlineLineNumber', { fg = '#ffd700', bold = true })
  vim.api.nvim_set_hl(0, 'HtmlOutlineComment', { fg = '#dcdcdc' })
end

local function apply_syntax_highlighting()
  if not vim.api.nvim_buf_is_valid(state.buf) then
    return
  end
  local ns_id = vim.api.nvim_create_namespace 'html_comment_outline'
  vim.api.nvim_buf_clear_namespace(state.buf, ns_id, 0, -1)
  for i, line in ipairs(vim.api.nvim_buf_get_lines(state.buf, 0, -1, false)) do
    local n = i - 1
    if line:match '📁 HTML Comments' then
      vim.api.nvim_buf_add_highlight(state.buf, ns_id, 'HtmlOutlineTitle', n, 0, -1)
    end
    if line:match '├─' or line:match '└─' then
      local b = line:find '[├└]─'
      if b then
        vim.api.nvim_buf_add_highlight(state.buf, ns_id, 'HtmlOutlineBranch', n, b - 1, b + 1)
      end
      local l = line:find '▶'
      if l then
        vim.api.nvim_buf_add_highlight(state.buf, ns_id, 'HtmlOutlineLeaf', n, l - 1, l)
      end
      local m = line:match '%[(%d+)%]'
      if m then
        local s = line:find('%[' .. m .. '%]')
        if s then
          vim.api.nvim_buf_add_highlight(state.buf, ns_id, 'HtmlOutlineLineNumber', n, s - 1, s + #m + 1)
        end
      end
      local cs = line:find '%] '
      if cs then
        vim.api.nvim_buf_add_highlight(state.buf, ns_id, 'HtmlOutlineComment', n, cs + 1, -1)
      end
    end
    if line:match '│' then
      local p = line:find '│'
      if p then
        vim.api.nvim_buf_add_highlight(state.buf, ns_id, 'HtmlOutlineBranch', n, p - 1, p)
      end
    end
  end
end

local function setup_outline_keymaps()
  local function map(mode, key, fn, desc)
    vim.keymap.set(mode, key, fn, { buffer = state.buf, silent = true, desc = desc })
  end
  map('n', '<CR>', function()
    local line = vim.api.nvim_win_get_cursor(state.win)[1]
    local index = get_comment_index_from_line(line)
    if index then
      jump_to_comment(index)
    end
  end, 'Jump to comment')
  map('n', '<2-LeftMouse>', function()
    local line = vim.api.nvim_win_get_cursor(state.win)[1]
    local index = get_comment_index_from_line(line)
    if index then
      jump_to_comment(index)
    end
  end, 'Jump to comment')
  map('n', 'q', function()
    M.close()
  end, 'Close outline')
  map('n', '<Esc>', function()
    M.close()
  end, 'Close outline')
  map('n', '?', function()
    vim.notify(
      [[<CR>/<Click> - Jump | q/<Esc> - Close | r - Refresh | ? - Help]],
      vim.log.levels.INFO,
      { title = 'HTML Comment Outline' }
    )
  end, 'Help')
end

local function create_outline_window()
  state.source_buf = vim.api.nvim_get_current_buf()
  state.comments = extract_comments(state.source_buf)

  if not state.buf or not vim.api.nvim_buf_is_valid(state.buf) then
    state.buf = vim.api.nvim_create_buf(false, true)
    vim.bo[state.buf].bufhidden = 'wipe'
    vim.bo[state.buf].filetype = 'html-comment-outline'
    vim.bo[state.buf].buftype = 'nofile'
    vim.bo[state.buf].swapfile = false
    vim.bo[state.buf].modifiable = false
    vim.api.nvim_buf_set_name(state.buf, 'HTML Comment Outline')
    setup_highlights()
  end

  local content = create_outline_content(state.comments)
  vim.bo[state.buf].modifiable = true
  vim.api.nvim_buf_set_lines(state.buf, 0, -1, false, content)
  vim.bo[state.buf].modifiable = false
  apply_syntax_highlighting()

  if not state.win or not vim.api.nvim_win_is_valid(state.win) then
    local current_win = vim.api.nvim_get_current_win()
    vim.cmd(config.position == 'right' and 'vsplit' or 'leftabove vsplit')
    state.win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_buf(state.win, state.buf)
    vim.wo[state.win].wrap = false
    vim.wo[state.win].cursorline = true
    vim.wo[state.win].number = false
    vim.wo[state.win].relativenumber = false
    vim.wo[state.win].signcolumn = 'no'
    vim.api.nvim_win_set_width(state.win, config.width)
    setup_outline_keymaps()
    vim.api.nvim_set_current_win(current_win)
  end

  state.is_open = true
end

function M.open()
  if not state.is_open then
    create_outline_window()
  end
end

function M.close()
  if state.win and vim.api.nvim_win_is_valid(state.win) then
    vim.api.nvim_win_close(state.win, true)
  end
  state.win = nil
  state.is_open = false
end

function M.toggle()
  if state.is_open then
    M.close()
  else
    M.open()
  end
end

function M.refresh()
  if state.is_open then
    create_outline_window()
  end
end

function M.setup(opts)
  config = vim.tbl_deep_extend('force', config, opts or {})
  vim.api.nvim_create_user_command('HtmlCommentOutline', M.toggle, { desc = 'Toggle HTML comment outline' })
  vim.api.nvim_create_user_command('HtmlCommentOutlineRefresh', M.refresh, { desc = 'Refresh HTML comment outline' })

  if config.auto_open then
    vim.api.nvim_create_autocmd({ 'BufEnter' }, {
      pattern = { '*.js', '*.jsx', '*.ts', '*.tsx', '*.html', '*.vue' },
      callback = M.open,
    })
  end

  vim.api.nvim_create_autocmd({ 'TextChanged', 'TextChangedI' }, {
    pattern = { '*.js', '*.jsx', '*.ts', '*.tsx', '*.html', '*.vue' },
    callback = function()
      if state.is_open then
        vim.defer_fn(M.refresh, 500)
      end
    end,
  })
end

return M
