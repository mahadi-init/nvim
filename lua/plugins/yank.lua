return {
  'rachartier/tiny-glimmer.nvim',
  event = 'TextYankPost',
  opts = {},
  config = function()
    require('tiny-glimmer').setup {
      enabled = true,
      default_animation = 'left_to_right',
      refresh_interval_ms = 6,
      transparency_color = nil,
      animations = {
        left_to_right = {
          max_duration = 300,
          chars_for_max_duration = 40,
          lingering_time = 50,
        },
      },
      virt_text = {
        priority = 2048,
      },
    }
  end,
}
