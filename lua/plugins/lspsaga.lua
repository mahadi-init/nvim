return {
  'nvimdev/lspsaga.nvim',
  event = 'VeryLazy',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('lspsaga').setup {
      lightbulb = {
        enable = false,
        enable_in_insert = false,
        sign = false,
        sign_priority = 40,
        virtual_text = false,
      },
      symbol_in_winbar = {
        enable = true,
        separator = ' › ',
        hide_keyword = false,
        show_file = true,
        folder_level = 2,
        color_mode = true,
        delay = 300,
      },
    }
  end,
}
