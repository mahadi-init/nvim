return {
  'williamboman/mason-lspconfig.nvim',
  config = function()
    require('mason').setup {
      ensure_installed = {
        'lua_ls',
        'eslint-lsp',
        'prettierd',
        'prettier',
        'tailwindcss-language-server',
        'typescript-language-server',
        'html-lsp',
      },
    }
  end,
}
