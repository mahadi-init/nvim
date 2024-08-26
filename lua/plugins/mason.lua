return {
  'williamboman/mason.nvim',
  dependencies = {
    'neovim/nvim-lspconfig',
  },
  config = function()
    require('mason').setup {
      ui = {
        icons = {
          package_installed = '✓',
          package_pending = '➜',
          package_uninstalled = '✗',
        },
      },
    }
  end,
}
