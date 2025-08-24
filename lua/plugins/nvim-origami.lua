return {
  'chrisgrieser/nvim-origami',
  opts = {},
  event = 'VeryLazy',
  lazy = false,
  config = function()
    require('origami').setup {
      autoFold = {
        enabled = false,
      },
      foldKeymaps = {
        setup = false,
      },
    }
  end,
}
