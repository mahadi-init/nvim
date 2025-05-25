return {
  'kevinhwang91/nvim-ufo',
  event = 'VeryLazy',
  dependencies = {
    'kevinhwang91/promise-async',
    event = 'VeryLazy',
  },
  config = function()
    require('ufo').setup {
      provider_selector = function()
        return { 'treesitter', 'indent' }
      end,
    }

    vim.keymap.set('n', 'zz', 'zzza', { remap = false, desc = 'Center screen and toggle fold' })
    vim.keymap.set('n', 'zo', require('ufo').openAllFolds)
  end,
}
