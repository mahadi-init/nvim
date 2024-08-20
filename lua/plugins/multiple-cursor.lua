return {
  "brenton-leighton/multiple-cursors.nvim",
  version = "*",
  opts = {},
  keys = {
    { "<C-Up>",   "<CMD>MultipleCursorsAddUp<CR>",   mode = { "n", "i", "x" }, desc = "Add cursor and move up" },
    { "<C-Down>", "<CMD>MultipleCursorsAddDown<CR>", mode = { "n", "i", "x" }, desc = "Add cursor and move down" },
  },
}
