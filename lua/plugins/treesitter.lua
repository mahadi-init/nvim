return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  config = function()
    require('nvim-treesitter.configs').setup {
      highlight = {
        enable = false,
      },
    }
  end,
}
