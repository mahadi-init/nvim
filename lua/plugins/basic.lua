return {
  "Raimondi/delimitMate",  -- Auto close brackes and parenthesis
  "nvim-treesitter/nvim-treesitter", -- syntax highlighting
{
"ibhagwan/fzf-lua",
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
