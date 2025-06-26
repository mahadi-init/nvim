return {
  dir = "~/.config/nvim/lua/notes/",
  name = "notes",
  lazy = true,
  cmd = { "NoteNew", "NoteOpen", "NoteByTag", "NoteSync" },
  keys = {
    { "<leader>nn", "<cmd>NoteNew<CR>" },
    { "<leader>no", "<cmd>NoteOpen<CR>" },
    { "<leader>nt", "<cmd>NoteByTag<CR>" },
    { "<leader>ns", "<cmd>NoteSync<CR>" },
  },
  config = function()
    require("notes").setup()
  end,
}
