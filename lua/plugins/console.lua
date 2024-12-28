return {
  'Goose97/timber.nvim',
  version = '*',
  event = 'VeryLazy',
  config = function()
    require('timber').setup {
      keymaps = {
        insert_log_below = '<C-A-L>',
        insert_plain_log_below = '<C-L>',
      },
    }
  end,
}
