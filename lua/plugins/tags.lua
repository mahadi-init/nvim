return {
  dir = '~/.config/nvim/lua/tags/',
  name = 'tags',
  lazy = true,
  cmd = { 'TagAdd', 'TagRemove', 'TagShow', 'TagClear' },
  keys = {
    { '<C-a>', '<cmd>TagAdd<CR>' },
    { '<C-t>', '<cmd>TagShow<CR>' },
    { '<C-c>', '<cmd>TagRemove<CR>' },
    { '<leader>tc', '<cmd>TagClear<CR>' },
  },
  config = function()
    require('tags').setup()
  end,
}
