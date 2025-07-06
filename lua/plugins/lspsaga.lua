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
      outline = {
        close_after_jump = false,
        win_width = 35,
        auto_preview = false,
        layout = 'normal',
      },
    }

    Key('n', '<C-o>', '<CMD>Lspsaga outline<CR>')
  end,
}
