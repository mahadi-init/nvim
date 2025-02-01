return {
  'nvimdev/lspsaga.nvim',
  event = 'VeryLazy',
  dependencies = {
    'nvim-treesitter/nvim-treesitter', -- optional
    'nvim-tree/nvim-web-devicons', -- optional
  },
  config = function()
    require('lspsaga').setup {
      lightbulb = {
        enable = false, -- Disable the lightbulb feature
        enable_in_insert = false, -- Disable in insert mode if applicable
        sign = true, -- Keep sign if needed
        sign_priority = 40,
        virtual_text = false, -- Disable virtual text if needed
      },
      symbol_in_winbar = {
        enable = false, -- Set this to false to disable breadcrumbs
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
