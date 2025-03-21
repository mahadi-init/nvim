return {
  'stevearc/conform.nvim',
  event = 'VeryLazy',
  config = function()
    require('conform').setup {
      formatters_by_ft = {
        lua = { 'stylua' },
        go = {
          'gopls',
        },
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
        json = {
          'prettierd',
        },
      },
      format_after_save = {
        lsp_format = 'fallback',
      },
    }
  end,
}
