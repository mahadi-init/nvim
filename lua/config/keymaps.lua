-- diffview
vim.api.nvim_set_keymap("n", "<leader>go", ":DiffviewOpen<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>gx", ":DiffviewClose<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>gm", ":DiffviewFileHistory %<CR>", { noremap = true, silent = true })
