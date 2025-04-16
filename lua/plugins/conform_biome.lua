return {
  'stevearc/conform.nvim',
  event = 'VeryLazy',
  config = function()
    local js_ts_formatters = {
      'biome',
      'prettier',
      'prettierd',
      stop_after_first = true,
    }

    local prettier_formatters = {
      'prettier',
      'prettierd',
      stop_after_first = true,
    }

    require('conform').setup {
      formatters_by_ft = {
        lua = { 'stylua' },
        javascript = js_ts_formatters,
        typescript = js_ts_formatters,
        typescriptreact = js_ts_formatters,
        html = js_ts_formatters,
        css = js_ts_formatters,
        json = prettier_formatters,
      },
      format_after_save = {
        lsp_format = 'fallback',
      },
    }
  end,
}
