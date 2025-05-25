return {
  'sindrets/diffview.nvim',
  event = 'VeryLazy',
  config = function()
    vim.keymap.set('n', '<leader>do', '<CMD>DiffviewOpen<CR>')
    vim.keymap.set('n', '<leader>df', '<CMD>DiffviewFileHistory %<CR>')
    vim.keymap.set('n', '<leader>dc', '<CMD>DiffviewClose<CR>')
  end,
}
