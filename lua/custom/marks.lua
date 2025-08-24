-- Make marks table global so winbar can access it
_G.marks = _G.marks or {}

-- Helper: relative path
local function relpath(path)
  return vim.fn.fnamemodify(path, ':~:.')
end

-- Helper: find current file's mark number
function _G.current_mark_number()
  local buf = vim.fn.expand '%:p' -- absolute path of current buffer
  for i, f in ipairs(_G.marks) do
    if f == buf then
      return '󰍎 ' .. i -- icon + number
    end
  end
  return '󰍑 ' -- not marked
end

-- Add current file to marks
vim.keymap.set('n', '<C-a>', function()
  local file = vim.fn.expand '%:p'
  for _, f in ipairs(_G.marks) do
    if f == file then
      vim.notify('Already marked: ' .. relpath(file), vim.log.levels.INFO)
      return
    end
  end
  table.insert(_G.marks, 1, file)
  vim.notify('Marked: ' .. relpath(file))
  vim.cmd 'redrawstatus' -- ✅ update winbar
end)

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
          vim.notify('Removed: ' .. relpath(choice))
          vim.cmd 'redrawstatus' -- ✅ update winbar
          return
        end
      end
    end
  end)
end)

-- Quick navigation
for i = 1, 9 do
  vim.keymap.set('n', '<C-' .. i .. '>', function()
    local file = _G.marks[i]
    if file then
      vim.cmd('edit ' .. vim.fn.fnameescape(file))
    else
      vim.notify('No file at slot ' .. i, vim.log.levels.WARN)
    end
  end, { desc = 'Jump to mark ' .. i })
end
