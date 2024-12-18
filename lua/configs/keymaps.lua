local telescope = require 'telescope.builtin'

vim.keymap.set({ 'n', 'i', 'v' }, '<C-s>', '<CMD>w<CR>') -- save file
vim.keymap.set('n', '<leader>q', '<CMD>q<CR>')           -- quit neovim
vim.keymap.set('n', '<ESC>', '<CMD>nohlsearch<CR>')      -- escape and remove search query
vim.keymap.set('n', '<C-j>', '<C-d>zz')                  -- scroll down
vim.keymap.set('n', '<C-k>', '<C-u>zz')                  -- scroll up
vim.keymap.set('n', '<C-d>', '<C-d>zz')                  -- scroll down
vim.keymap.set('n', '<C-u>', '<C-u>zz')                  -- scroll up
vim.keymap.set('n', '<C-v>', '<CMD>vsplit<CR>')          -- vertical split
vim.keymap.set('n', '<C-Right>', '<CMD>bnext<CR>')       -- next buffer
vim.keymap.set('n', '<C-Left>', '<CMD>bprevious<CR>')    -- previous buffer

-- telescope
vim.keymap.set('n', '<leader><leader>', telescope.find_files, { desc = 'find files' }) -- find files
vim.keymap.set('n', '<leader>fw', telescope.live_grep, { desc = 'find words' })        -- live grep
vim.keymap.set('n', '<leader>b', telescope.buffers, { desc = 'find buffer' })          -- find buffers
vim.keymap.set('n', '<leader>fq', telescope.quickfix, { desc = 'quickfix locallist' }) -- quickfix
vim.keymap.set('n', '<leader>fg', telescope.git_files, { desc = 'git files' })         -- git files
vim.keymap.set('n', '<leader>fs', telescope.git_status, { desc = 'git status' })       -- git status

-- file tree
vim.keymap.set('n', '<leader>e', '<CMD>Neotree filesystem toggle<CR>', { desc = 'neo tree open' }) -- file tree

-- session
vim.keymap.set('n', '<leader>ls', function()
  require('persistence').load()
end)

-- lazygit
vim.keymap.set('n', '<leader>gg', '<CMD>LazyGit<CR>', { desc = 'LazyGit' }) -- file tree

-- buf delete
vim.keymap.set('n', '<C-x>', '<CMD>lua Snacks.bufdelete()<CR>', { desc = 'Delete buffer' })

-- show current line blame
vim.api.nvim_set_keymap('n', '<leader>gb', '<CMD>lua Snacks.git.blame_line()<CR>', { noremap = true, silent = true })

-- spectre
vim.keymap.set('n', '<C-t>', '<CMD>lua require("spectre").toggle()<CR>', {
  desc = 'Toggle Spectre',
})
vim.keymap.set({ 'n', 'v' }, '<C-f>', '<CMD>lua require("spectre").open_file_search({select_word=true})<CR>', {
  desc = 'Search on current file',
})

-- quickfix
vim.keymap.set("n", "<M-c>", "<CMD>copen<CR>", { desc = "Open quickfix" })
vim.keymap.set("n", "<M-x>", "<CMD>cclose<CR>", { desc = "close quickfix" })
vim.keymap.set("n", "<M-k>", "<CMD>cnext<CR>", { desc = "next quickfix" })
vim.keymap.set("n", "<M-j>", "<CMD>cprev<CR>", { desc = "previous quickfix" })

-- resize window
vim.keymap.set("n", "=", [[<cmd>vertical resize +5<cr>]]) -- make the window biger vertically
vim.keymap.set("n", "-", [[<cmd>vertical resize -5<cr>]]) -- make the window smaller vertically
