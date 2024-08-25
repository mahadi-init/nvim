return {
  'echasnovski/mini.nvim',
  version = false,
  config = function()
    require('mini.tabline').setup()
    require('mini.pairs').setup()
  end
}
