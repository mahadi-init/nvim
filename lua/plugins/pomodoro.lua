return {
  'epwalsh/pomo.nvim',
  version = '*',
  lazy = true,
  cmd = { 'TimerStart', 'TimerRepeat', 'TimerSession' },
  opts = {},
  config = function()
    require('pomo').setup {
      sessions = {
        pomodoro = {
          { name = 'Work', duration = '25m' },
          { name = 'Short Break', duration = '5m' },
          { name = 'Work', duration = '25m' },
          { name = 'Short Break', duration = '5m' },
          { name = 'Work', duration = '25m' },
          { name = 'Long Break', duration = '15m' },
        },
      },
      notifiers = {
        {
          name = 'Default',
          opts = {
            sticky = false,

            title_icon = '󱎫',
            text_icon = '󰄉',
          },
        },
        { name = 'System' },
      },
    }

    require('telescope').load_extension 'pomodori'
    vim.keymap.set('n', '<leader>ps', ':TimerStart ', { desc = 'pomodoro start' })
  end,
}
