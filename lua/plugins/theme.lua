return {
  'rebelot/kanagawa.nvim',
  lazy = false,
  priority = 1000,
  opts = {},
  config = function()
    require('kanagawa').setup {
      compile = false, -- enable compiling the colorscheme
      undercurl = false, -- enable undercurls
      commentStyle = { italic = false },
      functionStyle = { bold = false },
      keywordStyle = { italic = false },
      statementStyle = { bold = false },
      typeStyle = { bold = false },
      transparent = false, -- do not set background color
      dimInactive = false, -- dim inactive window `:h hl-NormalNC`
      terminalColors = true, -- define vim.g.terminal_color_{0,17}
      colors = { -- add/modify theme and palette colors
        palette = {},
        theme = {
          wave = {},
          lotus = {},
          dragon = {},
          all = {
            ui = {
              bg_gutter = 'none',
            },
          },
        },
      },
      theme = 'dragon', -- Load "wave" theme when 'background' option is not set
      background = { -- map the value of 'background' option to a theme
        dark = 'dragon', -- try "dragon" !
        light = 'lotus',
      },
    }

    vim.cmd 'colorscheme kanagawa'
  end,
}
