return {
  'echasnovski/mini.nvim',
  version = false,
  config = function()
    require('mini.icons').setup()
    require('mini.tabline').setup()
    require('mini.pairs').setup()
    require('mini.indentscope').setup()
    require('mini.animate').setup({
      scroll = {
        enable = false
      }
    })
  end
}
