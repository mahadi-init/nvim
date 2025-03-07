return {
  'saghen/blink.cmp',
  version = '*',
  event = 'VeryLazy',
  opts = {
    keymap = {
      preset = 'none',
      ['<CR>'] = { 'accept', 'fallback' },
      ['<S-Tab>'] = { 'hide', 'fallback' },

      ['<Tab>'] = { 'select_next', 'fallback' },
      ['<Up>'] = { 'select_prev', 'fallback' },
      ['<Down>'] = { 'select_next', 'fallback' },

      ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
    },
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = 'mono',
    },
    sources = {
      default = { 'lsp', 'buffer', 'path', 'snippets' },
    },
    completion = {
      accept = { auto_brackets = { enabled = false } },
      menu = {
        draw = {
          columns = {
            { 'kind_icon', 'label', 'label_description', gap = 1 },
          },
          components = {
            label = {
              text = function(ctx)
                return ctx.item.label
              end,
              highlight = function(ctx)
                return ctx.highlights
              end,
            },
          },
        },
      },
    },
  },
  opts_extend = { 'sources.default' },
}
