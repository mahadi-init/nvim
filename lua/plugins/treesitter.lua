return {
  'nvim-treesitter/nvim-treesitter',
  event = 'VeryLazy',
  config = function()
    require('nvim-treesitter.configs').setup {
      highlight = {
        enable = true,
      },
    }
  end,
}
