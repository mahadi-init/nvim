local cmp = require("cmp")
local map = cmp.mapping

cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ['C-b'] = map.scroll_docs(-4),
    ['C-f'] = map.scroll_docs(4),
    ['C-a'] = map.complete(),
    ['C-e'] = map.abort(),
    ['<CR>'] = map.confirm({ select = true })
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' }
  }, {
    { name = 'buffer' }
  })
})
