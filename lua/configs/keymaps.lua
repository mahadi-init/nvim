-- native keymaps
vim.keymap.set({ 'n', 'i', 'v' }, '<C-s>', '<CMD>w<CR>') -- save file
vim.keymap.set('n', '<leader>q', '<CMD>q<CR>')           -- quit neovim
vim.keymap.set('n', '<ESC>', '<CMD>nohlsearch<CR>')      -- escape and remove search query
vim.keymap.set('n', '<C-j>', '<C-d>zz')                  -- scroll down
vim.keymap.set('n', '<C-k>', '<C-u>zz')                  -- scroll up
vim.keymap.set('n', '<C-d>', '<C-d>zz')                  -- scroll down
vim.keymap.set('n', '<C-u>', '<C-u>zz')                  -- scroll up
vim.keymap.set('n', '<C-v>', '<CMD>vsplit<CR>')          -- vertical split

-- quickfix
vim.keymap.set('n', '<M-o>', '<CMD>copen<CR>', { desc = 'Open quickfix' })
vim.keymap.set('n', '<M-x>', '<CMD>cclose<CR>', { desc = 'close quickfix' })
vim.keymap.set('n', '<M-k>', '<CMD>cprev<CR>', { desc = 'previous quickfix' })
vim.keymap.set('n', '<M-j>', '<CMD>cnext<CR>', { desc = 'next quickfix' })

-- resize window
vim.keymap.set('n', '=', [[<cmd>vertical resize +5<cr>]]) -- make the window biger vertically
vim.keymap.set('n', '-', [[<cmd>vertical resize -5<cr>]]) -- make the window smaller vertically

-- buffer switch
vim.keymap.set('n', '<C-Right>', '<CMD>bnext<CR>')
vim.keymap.set('n', '<C-Left>', '<CMD>bprev<CR>')

-- session
vim.keymap.set('n', '<leader>ls', function()
  require('persistence').load()
end)
