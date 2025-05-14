-- Neovim Configuration Entry Point
-- Last updated: 2023 Edition
-- Core settings
require 'configs.options'
require 'configs.autocmds'
require 'configs.diagnostics'
require 'configs.lazy'
require 'configs.keymaps'

-- Initialize LSP after plugins are loaded
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    require('configs.lsp').setup()
  end,
})
