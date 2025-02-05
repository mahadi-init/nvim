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
        offsets = {
          {
            filetype = 'neo-tree',
            text = ' File Explorer',
            highlight = 'Directory',
            separator = true,
          },
        },
        diagnostics_update_on_event = true,
        diagnostics_indicator = function(count)
          return '(' .. count .. ')'
        end,
        custom_filter = function(buf_number, buf_numbers)
          if vim.bo[buf_number].filetype ~= '<i-dont-want-to-see-this>' then
            return true
          end
          if vim.fn.bufname(buf_number) ~= '<buffer-name-I-dont-want>' then
            return true
          end
          if vim.fn.getcwd() == '<work-repo>' and vim.bo[buf_number].filetype ~= 'wiki' then
            return true
          end
          if buf_numbers[1] ~= buf_number then
            return true
          end
        end,
      },
    }
  end,
}
