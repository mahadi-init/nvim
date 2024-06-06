-- diffview
vim.api.nvim_set_keymap("n", "<leader>go", ":DiffviewOpen<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>gx", ":DiffviewClose<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>gm", ":DiffviewFileHistory %<CR>", { noremap = true, silent = true })

-- List available databases
vim.api.nvim_set_keymap(
  "n",
  "<Leader>z",
  ':lua require("mongo-nvim.telescope.pickers").database_picker()<CR>',
  { noremap = true, silent = true }
)
