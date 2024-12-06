return {
  "Raimondi/delimitMate",  -- Auto close brackes and parenthesis
  "nvim-treesitter/nvim-treesitter", -- syntax highlighting
  "lambdalisue/vim-fern", -- file tree
{ "ellisonleao/gruvbox.nvim", priority = 1000 , config = true,
config = function()
-- Default options:
require("gruvbox").setup({
  terminal_colors = true, -- add neovim terminal colors
  undercurl = true,
  underline = true,
  bold = true,
  italic = {
    strings = false,
    emphasis = false,
    comments = true,
    operators = false,
    folds = false,
  },
  strikethrough = true,
  invert_selection = false,
  invert_signs = false,
  invert_tabline = false,
  invert_intend_guides = false,
  inverse = true, -- invert background for search, diffs, statuslines and errors
  contrast = "", -- can be "hard", "soft" or empty string
  palette_overrides = {},
  overrides = {},
  dim_inactive = false,
  transparent_mode = false,
})
vim.cmd("colorscheme gruvbox")
end
},
{
"ibhagwan/fzf-lua",  -- fzf searching
-- optional for icon support
dependencies = { "nvim-tree/nvim-web-devicons" },
config = function()
  -- calling `setup` is optional for customization
  require("fzf-lua").setup({
    defaults = {
      git_icons = false,
      file_icons = false,
      color_icons = false
    }
  })
end
}
}
