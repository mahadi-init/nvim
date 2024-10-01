return {
  'stevearc/conform.nvim',
  config = function()
    require('conform').setup {
      formatters_by_ft = {
        lua = { 'stylua' },
        go = { 'gofumpt ' },
        javascript = {
          'prettierd',
          'prettier',
          async = true,
          lsp_fallback = true,
          quiet = true,
          stop_after_first = true,
        },
        typescript = {
          'prettierd',
          'prettier',
          async = true,
          lsp_fallback = true,
          quiet = true,
          stop_after_first = true,
        },
        typescriptreact = {
          'prettierd',
          'prettier',
          async = true,
          lsp_fallback = true,
          quiet = true,
          stop_after_first = true,
        },
        html = {
          'prettierd',
          'prettier',
          async = true,
          lsp_fallback = true,
          quiet = true,
          stop_after_first = true,
        },
        css = {
          'prettierd',
          'prettier',
          async = true,
          lsp_fallback = true,
          quiet = true,
          stop_after_first = true,
        },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_format = 'fallback',
      },
    }
    require('conform').format()
  end,
}
