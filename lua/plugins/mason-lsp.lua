return {
  'williamboman/mason-lspconfig.nvim',
  event = 'VeryLazy',
  config = function()
    require('mason-lspconfig').setup()
  end,
}
