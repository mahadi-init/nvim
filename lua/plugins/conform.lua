return {
  'stevearc/conform.nvim',
  config = function()
    require('conform').setup {
      formatters_by_ft = {
        lua = { 'stylua' },
        javascript = { 'prettierd', 'prettier' },
        typescript = { 'prettierd', 'prettier' },
        typescriptreact = { 'prettierd', 'prettier' },
        html = { 'prettierd', 'prettier' },
        css = { 'prettierd', 'prettier' },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_format = 'fallback',
      },
    }
    require('conform').format {
      async = true,
      lsp_fallback = true,
      quiet = true,
      stop_after_first = true,
    }
  end,
}
