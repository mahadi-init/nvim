local builtin = require 'telescope.builtin'

-- LSP Telescope
vim.keymap.set('n', '<leader><leader>', builtin.find_files)
vim.keymap.set('n', '<leader>fg', builtin.live_grep) -- live grep
vim.keymap.set('n', '<leader>fb', builtin.buffers) -- view buffers

-- TODO Telescope
vim.keymap.set('n', '<leader>ft', '<CMD>TodoTelescope<CR>') -- todo telescope

-- Git Telescope
vim.keymap.set('n', '<leader>gb', builtin.git_branches) -- git branches
vim.keymap.set('n', '<leader>gt', builtin.git_stash) -- git stash

-- Basic
vim.keymap.set('n', '<C-s>', '<CMD>w<CR>') -- save file
vim.keymap.set('i', '<C-s>', '<CMD>w<CR>') -- save file
vim.keymap.set('n', '<leader>q', '<CMD>q<CR>') -- quit neovim
vim.keymap.set('n', '<ESC>', '<CMD>nohlsearch<CR>') -- escape and remove search query
vim.keymap.set('n', '<C-Right>', '<CMD>BufferNext<CR>') -- next buffer
vim.keymap.set('n', '<C-Left>', '<CMD>BufferPrevious<CR>') -- previous buffer
vim.keymap.set('n', '<C-x>', '<CMD>BufferClose<CR>') -- delete buffer
vim.keymap.set('n', '<C-d>', '<C-d>zz') -- scroll down
vim.keymap.set('n', '<C-u>', '<C-u>zz') -- scroll up
vim.keymap.set('n', '<C-p>', '<Cmd>BufferPick<CR>') -- buffer pick

-- Diffview
vim.keymap.set('n', '<leader>dd', '<CMD>DiffviewOpen<CR>') -- diff view files
vim.keymap.set('n', '<leader>df', '<CMD>DiffviewFileHistory %<CR>') -- diff view current file
vim.keymap.set('n', '<leader>dc', '<CMD>DiffviewClose<CR>') -- diff view close

-- Split
vim.keymap.set('n', '<C-v>', '<CMD>vsplit<CR>') -- vertical split

-- Neotree
vim.keymap.set('n', '<leader>e', '<CMD>Neotree filesystem toggle<CR>') -- file tree
