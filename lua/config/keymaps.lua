local builtin = require('telescope.builtin')

-- telescope
vim.keymap.set('n', '<leader><leader>', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})

-- oil
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- basic
vim.keymap.set("n", "<C-s>", ":w<CR>", {})
vim.keymap.set("n", "<leader>q", ":q<CR>", {})
