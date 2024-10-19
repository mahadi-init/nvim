-- Using lazy.nvim
return {
  'ribru17/bamboo.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    require('bamboo').setup {
      style = 'multiplex', -- Choose between 'vulgaris' (regular), 'multiplex' (greener), and 'light'
      toggle_style_list = { 'vulgaris', 'multiplex', 'light' }, -- List of styles to toggle between
      transparent = true, -- Show/hide background
      dim_inactive = false, -- Dim inactive windows/buffers
      term_colors = true, -- Change terminal color as per the selected theme style
      ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
      cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu
      code_style = {
        comments = { italic = false },
        conditionals = { italic = false },
        keywords = {},
        functions = {},
        namespaces = { italic = false },
        parameters = { italic = false },
        strings = {},
        variables = {},
      },

      -- Lualine options --
      lualine = {
        transparent = true, -- lualine center bar transparency
      },
      colors = {},
      highlights = {
        -- make comments blend nicely with background, similar to other color schemes
        ['@comment'] = { fg = '$grey' },
      },

      -- Plugins Config --
      diagnostics = {
        darker = true, -- darker colors for diagnostic
        undercurl = true, -- use undercurl instead of underline for diagnostics
        background = true, -- use background color for virtual text
      },
    }
    require('bamboo').load()
  end,
}
