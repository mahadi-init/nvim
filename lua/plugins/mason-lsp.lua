return {
  'williamboman/mason-lspconfig.nvim',
  event = 'BufReadPre',
  config = function()
    require('mason-lspconfig').setup()
  end,
}
