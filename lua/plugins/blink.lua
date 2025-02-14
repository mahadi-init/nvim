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
      ['<Tab>'] = { 'select_next', 'fallback' },
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
      menu = {
        draw = {
          columns = { { 'kind_icon' }, { 'label', gap = 3 } },
          components = {
            label = {
              text = function(ctx)
                return require('colorful-menu').blink_components_text(ctx)
              end,
              highlight = function(ctx)
                return require('colorful-menu').blink_components_highlight(ctx)
              end,
            },
          },
        },
      },
    },
  },
  opts_extend = { 'sources.default' },
}
