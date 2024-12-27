return {
  'nvimdev/lspsaga.nvim',
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
    }
  end,
}
