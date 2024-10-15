local builtin = require 'telescope.builtin'

-- LSP Telescope
vim.keymap.set('n', '<leader><leader>', '<CMD>Telescope frecency workspace=CWD<CR>')
vim.keymap.set('n', '<leader>fg', builtin.live_grep) -- live grep
vim.keymap.set('n', '<leader>fb', builtin.buffers) -- view buffers
vim.keymap.set('n', '<leader>fd', '<CMD>FrecencyValidate!<CR>') -- remove entry

-- Telescope
vim.keymap.set('n', '<leader>ft', '<CMD>TodoTelescope<CR>') -- todo telescope

-- Git Telescope
vim.keymap.set('n', '<leader>gb', builtin.git_branches) -- git branches
vim.keymap.set('n', '<leader>gt', builtin.git_stash) -- git stash

-- Basic
vim.keymap.set('n', '<C-s>', '<CMD>w<CR>') -- save file
vim.keymap.set('i', '<C-s>', '<CMD>w<CR>') -- save file
vim.keymap.set('n', '<leader>q', '<CMD>q<CR>') -- quit neovim
vim.keymap.set('n', '<ESC>', '<CMD>nohlsearch<CR>') -- escape and remove search query
vim.keymap.set('n', '<C-Right>', '<CMD>bnext<CR>') -- next buffer
vim.keymap.set('n', '<C-Left>', '<CMD>bprevious<CR>') -- previous buffer
vim.keymap.set('n', '<C-d>', '<C-d>zz') -- scroll down
vim.keymap.set('n', '<C-u>', '<C-u>zz') -- scroll up

-- Diffview
vim.keymap.set('n', '<leader>dd', '<CMD>DiffviewOpen<CR>') -- diff view files
vim.keymap.set('n', '<leader>df', '<CMD>DiffviewFileHistory %<CR>') -- diff view current file
vim.keymap.set('n', '<leader>dc', '<CMD>DiffviewClose<CR>') -- diff view close

-- Split
vim.keymap.set('n', '<C-v>', '<CMD>vsplit<CR>') -- vertical split

-- Neotree
vim.keymap.set('n', '<leader>e', '<CMD>Neotree filesystem toggle<CR>') -- file tree

-- yanky
vim.keymap.set('n', '<leader>yy', '<CMD>lua require("telescope").extensions.yank_history.yank_history()<CR>')
