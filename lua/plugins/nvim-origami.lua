return {
  'chrisgrieser/nvim-origami',
  event = 'VeryLazy',
  opts = {},
  config = function()
    require('origami').setup {
      autoFold = {
        enabled = false,
      },
    }
  end,
}
