local builtin = require('telescope.builtin')

-- telescope
-- vim.keymap.set('n', '<leader><leader>', builtin.find_files, {})
vim.keymap.set('n', '<leader><leader>', ":Telescope frecency workspace=CWD<CR>", {}) -- open telescope
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})                             -- live grep
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})                               -- view buffers

-- oil
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" }) -- oil open parent dir

-- basic
vim.keymap.set("n", "<C-s>", ":w<CR>", {})     -- save file
vim.keymap.set("n", "<leader>q", ":q<CR>", {}) -- quit neovim

-- split
vim.keymap.set("n", "<C-v>", ":vsplit<CR>", {})
vim.keymap.set("n", "<C-x>", ":close<CR>", {})
