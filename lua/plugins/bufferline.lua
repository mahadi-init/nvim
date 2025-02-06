return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    local bufferline = require 'bufferline'

    require('bufferline').setup {
      options = {
        style_preset = bufferline.style_preset.no_italic,
        sort_by = 'insert_after_current',
        separator_style = 'slant',
        diagnostics = 'nvim_lsp',
        show_buffer_close_icons = false,
        offsets = {
          {
            filetype = 'neo-tree',
            text = ' File Explorer',
            highlight = 'Directory',
            separator = true,
          },
        },
        diagnostics_update_on_event = true,
      },
    }
  end,
}
