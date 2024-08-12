return {
  "hedyhli/outline.nvim",
  config = function()
    vim.keymap.set("n", "<leader>o", "<CMD>Outline<CR>",
      { desc = "Toggle Outline" })

    require("outline").setup()
  end,
}
