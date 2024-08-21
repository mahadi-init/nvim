return {
  'echasnovski/mini.nvim',
  version = false,
  config = function()
    require('mini.icons').setup()
    require('mini.tabline').setup()
    require('mini.pairs').setup()
    require('mini.indentscope').setup()
    require('mini.files').setup({
      content = {
        filter = nil,
        prefix = nil,
        sort = nil,
      },

      mappings = {
        close       = '<ESC>',
        go_in       = '',
        go_in_plus  = '<CR>',
        go_out      = '<BS>',
        go_out_plus = '',
        reset       = ';',
        reveal_cwd  = '',
        show_help   = 'g?',
        synchronize = 's',
        trim_left   = '<',
        trim_right  = '>',
      },

      options = {
        permanent_delete = true,
        use_as_default_explorer = true,
      },

      windows = {
        max_number = math.huge,
        preview = false,
        width_focus = 50,
        width_nofocus = 15,
        width_preview = 25,
      },
    })

    require('mini.animate').setup({
      scroll = {
        enable = false
      }
    })
  end
}
