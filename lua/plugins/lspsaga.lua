return {
  'nvimdev/lspsaga.nvim',
  event = 'VeryLazy',
  config = function()
    require('lspsaga').setup {
      lightbulb = {
        enable = false,
      },
      symbol_in_winbar = {
        enable = false,
      },
    }
  end,
}
