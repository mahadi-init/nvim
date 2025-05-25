return {
  'akinsho/bufferline.nvim',
  version = '*',
  config = function()
    local bufferline = require 'bufferline'

    require('bufferline').setup {
      options = {
        style_preset = bufferline.style_preset.no_italic,
        sort_by = 'insert_after_current',
        show_buffer_icons = true,
        separator_style = 'thin',
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

    vim.keymap.set('n', '<C-Right>', '<CMD>BufferLineCycleNext<CR>') -- next buffer
    vim.keymap.set('n', '<C-Left>', '<CMD>BufferLineCyclePrev<CR>') -- previous buffer
  end,
}
