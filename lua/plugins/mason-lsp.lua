return {
  'williamboman/mason-lspconfig.nvim',
  event = 'LspAttach',
  config = function()
    require('mason-lspconfig').setup()
  end,
}
