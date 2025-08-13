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

    Key('n', 'zo', require('ufo').openAllFolds)
    Key('n', 'zz', 'zzza', { remap = false, desc = 'Center screen and toggle fold' })
  end,
}
