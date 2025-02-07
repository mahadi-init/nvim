return {
  'supermaven-inc/supermaven-nvim',
  event = 'VeryLazy',
  config = function()
    require('supermaven-nvim').setup {
      keymaps = {
        accept_suggestion = '<Tab>',
      },
    }
  end,
}
