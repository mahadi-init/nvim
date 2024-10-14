local cmp = require 'cmp'
local map = cmp.mapping
local lspkind = require 'lspkind'
local cmp_buffer = require 'cmp_buffer'

require('luasnip.loaders.from_vscode').lazy_load()

cmp.setup {
  mapping = cmp.mapping.preset.insert {
    ['<CR>'] = map.confirm { select = true },
  },
  sources = cmp.config.sources {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    {
      name = 'buffer',
      option = {
        get_bufnrs = function()
          return vim.api.nvim_list_bufs()
        end,
      },
    },
    sorting = {
      comparators = {
        function(...)
          return cmp_buffer:compare_locality(...)
        end,
      },
    },
  },
  formatting = {
    format = lspkind.cmp_format {
      mode = 'symbol_text',
      maxwidth = 50,
      ellipsis_char = '...',
      show_labelDetails = true,
      before = function(_, vim_item)
        return vim_item
      end,
    },
  },
}
