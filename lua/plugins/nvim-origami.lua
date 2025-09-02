return {
  'chrisgrieser/nvim-origami',
  lazy = false,
  opts = {},
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
