return {
  'saghen/blink.cmp',
  event = 'VeryLazy',
  dependencies = 'rafamadriz/friendly-snippets',
  version = '*',
  opts = {
    keymap = {
      -- set to 'none' to disable the 'default' preset
      preset = 'none',

      ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
      ['<C-e>'] = { 'hide', 'fallback' },
      ['<CR>'] = { 'accept', 'fallback' },

      ['<Up>'] = { 'select_prev', 'fallback' },
      ['<Down>'] = { 'select_next', 'fallback' },

      ['<Tab>'] = { 'select_prev', 'fallback' },
      ['<S-Tab>'] = { 'select_next', 'fallback' },

      ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
    },
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = 'mono',
    },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
  },
  opts_extend = { 'sources.default' },
}
