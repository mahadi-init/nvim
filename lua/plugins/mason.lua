return {
  {
    'williamboman/mason.nvim',
    event = 'VeryLazy',
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
      require('mason').setup()
    end,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    event = 'VeryLazy',
    config = function()
      require('mason-lspconfig').setup()
    end,
  },
}
