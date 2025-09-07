return {
  'nvim-treesitter/nvim-treesitter',
  event = 'BufReadPre',
  config = function()
    require('nvim-treesitter.configs').setup {}
  end,
}
