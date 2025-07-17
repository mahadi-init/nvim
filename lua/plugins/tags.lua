return {
  dir = '~/.config/nvim/lua/tags/',
  name = 'tags',
  lazy = true,
  cmd = { 'TagAdd', 'TagRemove', 'TagShow', 'TagClear' },
  keys = {
    { '<C-a>', '<cmd>TagAdd<CR>' },
    { '<C-t>', '<cmd>TagShow<CR>' },
    { '<C-c>', '<cmd>TagClear<CR>' },
    { '<leader>tr', '<cmd>TagRemove<CR>' },
  },
  config = function()
    require('tags').setup()
  end,
}
