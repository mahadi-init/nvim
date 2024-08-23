local cmp = require("cmp")
local map = cmp.mapping
local lspkind = require('lspkind')

cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ['C-b'] = map.scroll_docs(-4),
    ['C-f'] = map.scroll_docs(4),
    ['C-a'] = map.complete(),
    ['C-e'] = map.abort(),
    ['<CR>'] = map.confirm({ select = true })
  }),
  sources = cmp.config.sources({
    { name = 'buffer' },
    { name = "treesitter" },
    { name = 'nvim_lsp' },
    { name = "path" },
  }),
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol_text',
      maxwidth = 50,
      ellipsis_char = '...',
      show_labelDetails = true,
      before = function(_, vim_item)
        return vim_item
      end
    })
  }
})
