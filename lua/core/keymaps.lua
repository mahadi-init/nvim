Key({ 'n', 'i', 'v' }, '<C-s>', '<CMD>w<CR>') -- save file
Key('n', '<ESC>', '<CMD>nohlsearch<CR>') -- escape and remove search query
Key('n', '<C-j>', '<C-d>zz') -- scroll down
Key('n', '<C-k>', '<C-u>zz') -- scroll up
Key('n', '<C-d>', '<C-d>zz') -- scroll down
Key('n', '<C-u>', '<C-u>zz') -- scroll up
Key('n', '<C-v>', '<CMD>leftabove vsplit<CR>') -- vertical split

-- quickfix
Key('n', '<M-o>', '<CMD>copen<CR>', { desc = 'Open quickfix' })
Key('n', '<M-x>', '<CMD>cclose<CR>', { desc = 'close quickfix' })
Key('n', '<M-k>', '<CMD>cprev<CR>', { desc = 'previous quickfix' })
Key('n', '<M-j>', '<CMD>cnext<CR>', { desc = 'next quickfix' })
Key('n', '<M-d>', function()
  local qf_list = vim.fn.getqflist()
  local current_line = vim.fn.line '.'
  table.remove(qf_list, current_line)
  vim.fn.setqflist(qf_list, 'r')
end, { desc = 'Remove current quickfix entry' })

-- resize window
Key('n', '=', [[<cmd>vertical resize +5<cr>]]) -- make the window biger vertically
-- Key('n', '-', [[<cmd>vertical resize -5<cr>]]) -- make the window smaller vertically

-- change between buffers
vim.keymap.set('n', '<C-Right>', ':bnext<CR>', { desc = 'Next buffer' })
vim.keymap.set('n', '<C-Left>', ':bprevious<CR>', { desc = 'Previous buffer' })

-- move lines
Key('n', '<M-Up>', ':m .-2<CR>==', { desc = 'Move line up' })
Key('v', '<M-Up>', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })
Key('n', '<M-Down>', ':m .+1<CR>==', { desc = 'Move line down' })
Key('v', '<M-Down>', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })

Key('n', '<leader>ls', function()
  require('persistence').load()
end)

-- buffer list view
vim.keymap.set('n', '<C-l>', function()
  local buffers = {}
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) then
      table.insert(buffers, {
        bufnr = buf,
        name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ':t'),
      })
    end
  end

  vim.ui.select(buffers, {
    prompt = 'Switch buffer:',
    format_item = function(item)
      return item.name
    end,
  }, function(choice)
    if choice then
      vim.api.nvim_set_current_buf(choice.bufnr)
    end
  end)
end, { desc = 'List buffers' })

-- buffer switch using number
for i = 1, 9 do
  vim.keymap.set('n', '<C-' .. i .. '>', function()
    local buffers = vim.t.bufs or vim.api.nvim_list_bufs() -- keep tab-local order if possible
    if i <= #buffers then
      vim.api.nvim_set_current_buf(buffers[i])
    end
  end, { desc = 'Go to buffer ' .. i })
end
