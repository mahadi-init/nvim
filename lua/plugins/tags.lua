return {
  dir = '~/.config/nvim/lua/tags/',
  name = 'tags',
  lazy = true,
  cmd = { 'TagAdd', 'TagRemove', 'TagShow', 'TagClear' },
  keys = {
    { '<C-m>', '<cmd>TagAdd<CR>' },
    { '<C-t>', '<cmd>TagShow<CR>' },
    { '<leader>tc', '<cmd>TagClear<CR>' },
  },
  config = function()
    require('tags').setup()
  end,
}
