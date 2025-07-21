return {
  dir = '~/.config/nvim/lua/notes/',
  name = 'notes',
  lazy = true,
  cmd = { 'NoteNew', 'NoteByTitle', 'NoteSync' },
  keys = {
    { '<leader>nn', '<cmd>NoteNew<CR>' },
    { '<leader>nt', '<cmd>NoteByTitle<CR>' },
    { '<leader>ns', '<cmd>NoteSync<CR>' },
  },
  config = function()
    require('notes').setup()
  end,
}
