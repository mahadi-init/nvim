-- Make marks table global so winbar can access it
_G.marks = _G.marks or {}
_G.current_mark_index = _G.current_mark_index or 1

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

-- Toggle mark on current file
vim.keymap.set('n', '<C-a>', function()
  local file = vim.fn.expand '%:p'
  for i, f in ipairs(_G.marks) do
    if f == file then
      table.remove(_G.marks, i)
      vim.notify('Unmarked: ' .. relpath(file))
      -- Adjust current_mark_index if needed
      if _G.current_mark_index > #_G.marks then
        _G.current_mark_index = #_G.marks
      end
      vim.cmd 'redrawstatus' -- refresh winbar
      return
    end
  end
  -- if not found, add it to the end
  table.insert(_G.marks, file)
  _G.current_mark_index = #_G.marks -- point to the new one
  vim.notify('Marked: ' .. relpath(file))
  vim.cmd 'redrawstatus' -- refresh winbar
end, { desc = 'Toggle mark' })

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
