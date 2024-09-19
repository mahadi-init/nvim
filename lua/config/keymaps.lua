local builtin = require 'telescope.builtin'

-- lsp telescope
vim.keymap.set('n', '<leader><leader>', builtin.find_files)
vim.keymap.set('n', '<leader>fg', builtin.live_grep) -- live grep
vim.keymap.set('n', '<leader>fb', builtin.buffers) -- view buffers

-- todo telescope
vim.keymap.set('n', '<leader>ft', '<CMD>TodoTelescope<CR>') -- todo telescope

-- git telescope
vim.keymap.set('n', '<leader>gc', builtin.git_commits) -- git commits
vim.keymap.set('n', '<leader>gb', builtin.git_branches) -- git branches
vim.keymap.set('n', '<leader>gs', builtin.git_status) -- git status
vim.keymap.set('n', '<leader>gt', builtin.git_stash) -- git stash

-- oil
vim.keymap.set('n', '-', '<CMD>Oil<CR>') -- oil open parent dir

-- basic
vim.keymap.set('n', '<C-s>', '<CMD>w<CR>') -- save file
vim.keymap.set('i', '<C-s>', '<CMD>w<CR>') -- save file
vim.keymap.set('n', '<leader>q', '<CMD>q<CR>') -- quit neovim
vim.keymap.set('n', '<ESC>', '<CMD>nohlsearch<CR>') -- escape and remove search query
vim.keymap.set('n', '<C-Right>', '<CMD>bnext<CR>') -- next buffer
vim.keymap.set('n', '<C-Left>', '<CMD>bprevious<CR>') -- previous buffer
vim.keymap.set('n', '<C-x>', '<CMD>bd<CR>') -- delete buffer
vim.keymap.set('n', '<C-d>', '<C-d>zz') -- upward
vim.keymap.set('n', '<C-u>', '<C-u>zz') -- downward

-- split
vim.keymap.set('n', '<C-v>', '<CMD>vsplit<CR>') -- split vertical

-- neotree
vim.keymap.set('n', '<leader>e', '<CMD>Neotree filesystem toggle<CR>') -- file tree
