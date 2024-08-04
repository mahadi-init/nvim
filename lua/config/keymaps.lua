local builtin = require('telescope.builtin')

-- telescope
-- vim.keymap.set('n', '<leader><leader>', builtin.find_files, {})
vim.keymap.set('n', '<leader><leader>', "<CMD>Telescope frecency workspace=CWD<CR>") -- open telescope
vim.keymap.set('n', '<leader>fg', builtin.live_grep)                                 -- live grep
vim.keymap.set('n', '<leader>fb', builtin.buffers)                                   -- view buffers

-- oil
vim.keymap.set("n", "-", "<CMD>Oil<CR>") -- oil open parent dir

-- basic
vim.keymap.set("n", "<C-s>", "<CMD>w<CR>")          -- save file
vim.keymap.set("n", "<leader>q", "<CMD>q<CR>")      -- quit neovim
vim.keymap.set("n", "<ESC>", "<CMD>nohlsearch<CR>") -- quit neovim

-- split
vim.keymap.set("n", "<C-v>", "<CMD>vsplit<CR>") -- split vertical
vim.keymap.set("n", "<C-x>", "<CMD>close<CR>")  -- close split
vim.keymap.set("n", "<C-X>", "<CMD>only<CR>")   -- close all splits

-- diagnostic
local diagnostic = vim.diagnostic
vim.keymap.set("n", "[d", diagnostic.goto_prev)          -- previous diagnostic
vim.keymap.set("n", "]d", diagnostic.goto_next)          -- next diagnostic
vim.keymap.set("n", "<leader>ld", diagnostic.open_float) -- open float diagnostic
vim.keymap.set("n", "<leader>lq", diagnostic.setloclist) -- open float diagnostic
