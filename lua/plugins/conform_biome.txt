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
          'biome',
        },
        typescript = {
          'biome',
        },
        typescriptreact = {
          'biome',
        },
        html = {
          'biome',
        },
        css = {
          'biome',
        },
        json = {
          'biome',
        },
      },
      format_after_save = {
        lsp_format = 'fallback',
      },
    }
  end,
}
