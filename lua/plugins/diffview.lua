return {
  'sindrets/diffview.nvim',
  event = 'VeryLazy',
  config = function()
    Key('n', '<leader>do', '<CMD>DiffviewOpen<CR>')
    Key('n', '<leader>df', '<CMD>DiffviewFileHistory %<CR>')
    Key('n', '<leader>dc', '<CMD>DiffviewClose<CR>')
  end,
}
