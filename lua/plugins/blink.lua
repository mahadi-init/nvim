return {
  'saghen/blink.cmp',
  version = '*',
  event = 'VeryLazy',
  opts = {
    keymap = {
      preset = 'none',
      ['<CR>'] = { 'accept', 'fallback' },
      ['<S-Tab>'] = { 'hide', 'fallback' },

      ['<Up>'] = { 'select_prev', 'fallback' },
      ['<Down>'] = { 'select_next', 'fallback' },

      ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
    },
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = 'mono',
    },
    sources = {
      default = { 'lsp', 'buffer', 'path' },
    },
  },
  opts_extend = { 'sources.default' },
}
