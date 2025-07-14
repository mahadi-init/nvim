local M = {}
local fzf = require 'fzf-lua'
local note_dir = vim.fn.stdpath 'data' .. '/nvim-notes'
local repo_url = 'https://github.com/mahadi-init/neovim-notes '

local function ensure_note_dir()
  if vim.fn.isdirectory(note_dir) == 0 then
    vim.fn.mkdir(note_dir, 'p')
  end
end

-- List all markdown notes
local function get_notes()
  ensure_note_dir()
  local files = vim.fn.readdir(note_dir)
  local filtered = {}

  for _, file in ipairs(files) do
    if file ~= '.git' and file:match '%.md$' then
      table.insert(filtered, file)
    end
  end

  table.sort(filtered)
  return filtered
end

-- Open a note via fzf
function M.open()
  ensure_note_dir()

  local files = vim.tbl_filter(function(file)
    return not file:match '^%.' and file:match '%.md$'
  end, vim.fn.readdir(note_dir))

  if #files == 0 then
    print 'No notes found.'
    return
  end

  fzf.fzf_exec(files, {
    prompt = 'Notes> ',
    previewer = false,
    actions = {
      ['default'] = function(selected)
        vim.cmd('edit ' .. note_dir .. '/' .. selected[1])
      end,
      ['ctrl-d'] = function(selected)
        local file = selected[1]
        local confirm = vim.fn.input("Delete '" .. file .. "'? (y/n): ")
        if confirm:lower() == 'y' then
          local ok = os.remove(note_dir .. '/' .. file)
          if ok then
            print('Deleted note:', file)
          else
            print 'Failed to delete.'
          end
        else
          print 'Aborted.'
        end
      end,
    },
  })
end

-- Create a new note
function M.new()
  ensure_note_dir()
  local name = vim.fn.input 'Note name: '
  if name == '' then
    name = os.date '%Y-%m-%d_%H-%M-%S'
  end
  local path = string.format('%s/%s.md', note_dir, name)

  if vim.fn.filereadable(path) == 0 then
    local file = io.open(path, 'w')
    if file then
      file:write '# New Note\n\n'
      file:close()
    end
  end

  vim.cmd('edit ' .. path)
end

-- Search notes by their title using fzf
function M.search_by_title()
  local notes = get_notes()
  if #notes == 0 then
    print 'No notes found.'
    return
  end

  fzf.fzf_exec(notes, {
    prompt = 'Search Notes by Filename> ',
    previewer = false,
    actions = {
      ['default'] = function(selected)
        local file = selected[1]
        vim.cmd('edit ' .. note_dir .. '/' .. file)
      end,
      ['ctrl-d'] = function(selected)
        local file = selected[1]
        local confirm = vim.fn.input("Delete '" .. file .. "'? (y/n): ")
        if confirm:lower() == 'y' then
          local ok = os.remove(note_dir .. '/' .. file)
          if ok then
            print('Deleted note:', file)
          else
            print 'Failed to delete.'
          end
        else
          print 'Aborted.'
        end
      end,
    },
  })
end

function M.sync()
  local path = vim.fn.expand(note_dir)

  if vim.fn.isdirectory(path) == 0 then
    print 'Cloning notes from GitHub...'
    local output = vim.fn.system { 'git', 'clone', repo_url, path }

    if vim.v.shell_error == 0 then
      print '✅ Notes cloned successfully.'
    else
      print '❌ Failed to clone repo:'
      print(output)
    end
    return
  end

  local status = vim.fn.system { 'git', '-C', path, 'status', '--porcelain' }

  if status ~= '' then
    print '🔄 Syncing notes to GitHub...'
    local timestamp = os.date '%Y-%m-%d %H:%M:%S'

    vim.fn.system { 'git', '-C', path, 'add', '.' }
    vim.fn.system { 'git', '-C', path, 'commit', '-m', 'sync: ' .. timestamp }
    local push_output = vim.fn.system { 'git', '-C', path, 'push' }

    if vim.v.shell_error == 0 then
      print '✅ Notes synced successfully.'
    else
      print '❌ Push failed:'
      print(push_output)
    end
  else
    print '🟢 No changes to sync.'
  end
end

function M.setup()
  vim.api.nvim_create_user_command('NoteNew', M.new, {})
  vim.api.nvim_create_user_command('NoteOpen', M.open, {})
  vim.api.nvim_create_user_command('NoteByTitle', M.search_by_title, {})
  vim.api.nvim_create_user_command('NoteSync', M.sync, {})
end

return M
