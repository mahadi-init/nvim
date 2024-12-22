return {
  'stevearc/conform.nvim',
  event = 'VeryLazy',
  config = function()
    require('conform').setup {
      formatters_by_ft = {
        lua = { 'stylua' },
        javascript = {
          'prettierd',
        },
        typescript = {
          'prettierd',
        },
        typescriptreact = {
          'prettierd',
        },
        html = {
          'prettierd',
        },
        css = {
          'prettierd',
        },
      },
      format_after_save = {
        lsp_format = 'fallback',
      },
    }
    require('conform').format()
  end,
}
