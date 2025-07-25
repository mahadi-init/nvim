Key({ 'n', 'i', 'v' }, '<C-s>', '<CMD>w<CR>') -- save file
Key('n', '<leader>q', '<CMD>q<CR>') -- quit neovim
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
--
vim.keymap.set('n', '<M-Up>', ':m .-2<CR>==', { desc = 'Move line up' })
vim.keymap.set('v', '<M-Up>', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })
vim.keymap.set('n', '<M-Down>', ':m .+1<CR>==', { desc = 'Move line down' })
vim.keymap.set('v', '<M-Down>', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })

-- buffer chnage
Key('n', '<C-Right>', '<CMD>bnext<CR>')
Key('n', '<C-Left>', '<CMD>bprev<CR>')

-- session
Key('n', '<leader>ls', function()
  require('persistence').load()
end)
