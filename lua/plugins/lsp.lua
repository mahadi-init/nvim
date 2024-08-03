return {
  {
    "williamboman/mason.nvim",
    -- opts = {
    --   ensure_installed = {
    --     "eslint-lsp",
    --     "prettierd",
    --     "tailwindcss-language-server",
    --     "typescript-language-server",
    --   }
    -- },
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
          }
        },
      })
    end
  },
  "williamboman/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig",
}
