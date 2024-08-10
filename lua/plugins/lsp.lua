return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
          }
        },
        ensure_installed = {
          "eslint-lsp",
          "prettierd",
          "tailwindcss-language-server",
          "typescript-language-server",
          "html-lsp"
        }
      })
    end
  },
  "williamboman/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig",
}
