-- Make marks table global so winbar can access it
_G.marks = _G.marks or {}
_G.current_mark_index = _G.current_mark_index or 1

-- === Project-based persistence ===
-- Helper: compute a safe filename based on cwd
local function get_marks_file()
  local cwd = vim.loop.cwd() or 'global'
  local safe = cwd:gsub('[^%w]', '_') -- sanitize
  return vim.fn.stdpath 'data' .. '/marks_' .. safe .. '.json'
end

-- Current project's marks file
local marks_file = get_marks_file()

-- Helper: relative path
local function relpath(path)
  return vim.fn.fnamemodify(path, ':~:.')
end

-- Helper: find current file's mark number
function _G.current_mark_number()
  local buf = vim.fn.expand '%:p' -- absolute path of current buffer
  for i, f in ipairs(_G.marks) do
    if f == buf then
      return '󰍎 ' .. i -- colored mark number
    end
  end
  return '󰍑 ' -- not marked
end

-- Add mark (always add, not toggle)
vim.keymap.set('n', '<C-a>', function()
  local file = vim.fn.expand '%:p'

  -- prevent duplicates
  for _, f in ipairs(_G.marks) do
    if f == file then
      vim.notify('Already marked: ' .. relpath(file), vim.log.levels.INFO)
      return
    end
  end

  table.insert(_G.marks, file)
  _G.current_mark_index = #_G.marks
  vim.notify('Marked: ' .. relpath(file))
  vim.cmd 'redrawstatus'
end, { desc = 'Add mark' })

-- Unmark current file
vim.keymap.set('n', '<C-x>', function()
  local file = vim.fn.expand '%:p'
  for i, f in ipairs(_G.marks) do
    if f == file then
      table.remove(_G.marks, i)
      if _G.current_mark_index > #_G.marks then
        _G.current_mark_index = #_G.marks
      end
      vim.notify('Unmarked: ' .. relpath(file))
      vim.cmd 'redrawstatus'
      return
    end
  end
  vim.notify('Not marked: ' .. relpath(file), vim.log.levels.WARN)
end, { desc = 'Unmark current file' })

-- Remove a mark
vim.keymap.set('n', '<C-e>', function()
  if vim.tbl_isempty(_G.marks) then
    vim.notify('No marks to remove', vim.log.levels.WARN)
    return
  end
  vim.ui.select(_G.marks, {
    prompt = 'Remove mark:',
    format_item = function(item)
      return relpath(item)
    end,
  }, function(choice)
    if choice then
      for i, f in ipairs(_G.marks) do
        if f == choice then
          table.remove(_G.marks, i)
          if _G.current_mark_index > #_G.marks then
            _G.current_mark_index = #_G.marks
          end
          vim.notify('Removed: ' .. relpath(choice))
          vim.cmd 'redrawstatus'
          return
        end
      end
    end
  end)
end)

-- Unmark all
vim.api.nvim_create_user_command('UnmarkAll', function()
  if vim.tbl_isempty(_G.marks) then
    vim.notify('No marks to clear', vim.log.levels.WARN)
    return
  end
  _G.marks = {}
  _G.current_mark_index = 1
  vim.notify 'All marks cleared'
  vim.cmd 'redrawstatus'
end, { desc = 'Clear all marks' })

-- Jump to marked file
vim.keymap.set('n', '<C-l>', function()
  if vim.tbl_isempty(_G.marks) then
    vim.notify('No marks yet', vim.log.levels.WARN)
    return
  end
  vim.ui.select(_G.marks, {
    prompt = 'Jump to file:',
    format_item = function(item)
      return relpath(item)
    end,
  }, function(choice)
    if choice then
      for i, f in ipairs(_G.marks) do
        if f == choice then
          _G.current_mark_index = i
          break
        end
      end
      vim.cmd('edit ' .. vim.fn.fnameescape(choice))
    end
  end)
end)

-- Jump to mark by index safely
local function goto_mark(i)
  local file = _G.marks[i]
  if file then
    _G.current_mark_index = i
    vim.cmd('edit ' .. vim.fn.fnameescape(file))
    vim.cmd 'redrawstatus' -- refresh winbar
  else
    vim.notify('No file at slot ' .. i, vim.log.levels.WARN)
  end
end

-- Cycle next
vim.keymap.set('n', '<C-Right>', function()
  if vim.tbl_isempty(_G.marks) then
    vim.notify('No marks yet', vim.log.levels.WARN)
    return
  end
  if #_G.marks == 1 then
    return
  end
  local next_i = _G.current_mark_index + 1
  if next_i > #_G.marks then
    next_i = 1
  end
  goto_mark(next_i)
end, { desc = 'Next mark' })

-- Cycle previous
vim.keymap.set('n', '<C-Left>', function()
  if vim.tbl_isempty(_G.marks) then
    vim.notify('No marks yet', vim.log.levels.WARN)
    return
  end
  if #_G.marks == 1 then
    return
  end
  local prev_i = _G.current_mark_index - 1
  if prev_i < 1 then
    prev_i = #_G.marks
  end
  goto_mark(prev_i)
end, { desc = 'Previous mark' })

-- Quick navigation by index
for i = 1, 9 do
  vim.keymap.set('n', '<C-' .. i .. '>', function()
    local file = _G.marks[i]
    if file then
      _G.current_mark_index = i
      vim.cmd('edit ' .. vim.fn.fnameescape(file))
    else
      vim.notify('No file at slot ' .. i, vim.log.levels.WARN)
    end
  end, { desc = 'Jump to mark ' .. i })
end

-- === Persistence ===

-- Save marks to file
local function save_marks()
  local json = vim.fn.json_encode(_G.marks)
  vim.fn.writefile({ json }, marks_file)
end

-- Load marks from file
local function load_marks()
  if vim.fn.filereadable(marks_file) == 1 then
    local lines = vim.fn.readfile(marks_file)
    if lines[1] then
      local ok, data = pcall(vim.fn.json_decode, lines[1])
      if ok and type(data) == 'table' then
        _G.marks = data
        _G.current_mark_index = #_G.marks
      end
    end
  end
end

-- Auto save on exit
vim.api.nvim_create_autocmd('VimLeavePre', {
  callback = save_marks,
})

-- Load marks on startup
load_marks()
