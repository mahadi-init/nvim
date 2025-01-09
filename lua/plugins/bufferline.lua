return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    require('bufferline').setup {
      options = {
        offsets = {
          { filetype = 'neo-tree', text_align = 'center' },
        },
        diagnostics = 'nvim_lsp',
        separator_style = 'thin',
        always_show_bufferline = true,
        reorder = true,
      },
    }

    vim.api.nvim_set_keymap('n', '<A-Right>', ':BufferLineMoveNext<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<A-Left>', ':BufferLineMovePrev<CR>', { noremap = true, silent = true })
  end,
}
