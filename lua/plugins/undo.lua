return {
  'debugloop/telescope-undo.nvim',
  event = 'VeryLazy',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    require('telescope').load_extension 'undo'
  end,
}
