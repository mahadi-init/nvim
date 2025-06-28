return {
  'MeanderingProgrammer/render-markdown.nvim',
  event = "VeryLazy",
  after = { 'nvim-treesitter' },
  config = function()
    require('render-markdown').setup({})
  end,
}
