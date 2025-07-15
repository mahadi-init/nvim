return {
  dir = '~/.config/nvim/lua/tags/',
  name = 'tags',
  lazy = true,
  cmd = { 'TagAdd', 'TagRemove', 'TagShow', 'TagClear' },
  keys = {
    { '<C-c>', '<cmd>TagAdd<CR>' },
    { '<C-t>', '<cmd>TagShow<CR>' },
    { '<leader>tr', '<cmd>TagRemove<CR>' },
    { '<leader>tc', '<cmd>TagClear<CR>' },
  },
  config = function()
    require('tags').setup()
  end,
}
