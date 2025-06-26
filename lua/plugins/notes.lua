return {
  dir = "~/.config/nvim/lua/notes/",
  name = "notes",
  lazy = true,
  cmd = { "NoteNew", "NoteOpen", "NoteByTag", },
  keys = {
    { "<leader>nn", "<cmd>NoteNew<CR>" },
    { "<leader>no", "<cmd>NoteOpen<CR>" },
    { "<leader>nt", "<cmd>NoteByTag<CR>" },
  },
  config = function()
    require("notes").setup()
  end,
}
