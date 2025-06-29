Key({ 'n', 'i', 'v' }, '<C-s>', '<CMD>w<CR>') -- save file
Key('n', '<leader>q', '<CMD>q<CR>')           -- quit neovim
Key('n', '<ESC>', '<CMD>nohlsearch<CR>')      -- escape and remove search query
Key('n', '<C-j>', '<C-d>zz')                  -- scroll down
Key('n', '<C-k>', '<C-u>zz')                  -- scroll up
Key('n', '<C-d>', '<C-d>zz')                  -- scroll down
Key('n', '<C-u>', '<C-u>zz')                  -- scroll up
Key('n', '<C-v>', '<CMD>vsplit<CR>')          -- vertical split

-- quickfix
Key('n', '<M-o>', '<CMD>copen<CR>', { desc = 'Open quickfix' })
Key('n', '<M-x>', '<CMD>cclose<CR>', { desc = 'close quickfix' })
Key('n', '<M-k>', '<CMD>cprev<CR>', { desc = 'previous quickfix' })
Key('n', '<M-j>', '<CMD>cnext<CR>', { desc = 'next quickfix' })

-- resize window
Key('n', '=', [[<cmd>vertical resize +5<cr>]]) -- make the window biger vertically
Key('n', '-', [[<cmd>vertical resize -5<cr>]]) -- make the window smaller vertically

-- buffer switch
Key('n', '<C-Right>', '<CMD>bnext<CR>')
Key('n', '<C-Left>', '<CMD>bprev<CR>')

-- session
Key('n', '<leader>ls', function()
  require('persistence').load()
end)
