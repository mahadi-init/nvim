return {
  'andrewferrier/debugprint.nvim',
  event = 'VeryLazy',
  opts = {
    keymaps = {
      normal = {
        variable_below = '<C-l>',
      },
    },
  },
  -- dependencies = {
  --   'echasnovski/mini.nvim', -- Optional: Needed for line highlighting (full mini.nvim plugin)
  --   'echasnovski/mini.hipatterns', -- Optional: Needed for line highlighting ('fine-grained' hipatterns plugin)
  --   'folke/snacks.nvim', -- Optional: If you want to use the `:Debugprint search` command with snacks.nvim
  -- },
  lazy = false,
  version = '*',
}
