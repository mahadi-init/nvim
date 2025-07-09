return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    vim.opt.termguicolors = true
    local bufferline = require 'bufferline'

    bufferline.setup {
      options = {
        style_preset = {
          bufferline.style_preset.no_italic,
        },
        diagnostics = 'nvim_lsp',
        sort_by = 'insert_at_end',
      },
    }

    -- buffer switch
    Key('n', '<C-Right>', '<CMD>bnext<CR>')
    Key('n', '<C-Left>', '<CMD>bprev<CR>')
  end,
}
