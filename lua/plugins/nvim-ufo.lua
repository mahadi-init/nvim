return {
  'kevinhwang91/nvim-ufo',
  dependencies = {
    'kevinhwang91/promise-async',
  },
  config = function()
    require('ufo').setup {
      provider_selector = function()
        return { 'treesitter', 'indent' }
      end,
    }

    Key('n', 'zz', 'zzza', { remap = false, desc = 'Center screen and toggle fold' })
    Key('n', 'zo', require('ufo').openAllFolds)
  end,
}
