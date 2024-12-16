-- Mason setup
require('mason').setup()
require('mason-lspconfig').setup()

local telescope = require 'telescope.builtin'

-- LSP config
local lspconfig = require 'lspconfig'
local capabilities = require('cmp_nvim_lsp').default_capabilities()

local on_attach = function(_, _)
  local buf = vim.lsp.buf
  local diagnostic = vim.diagnostic

  -- LSP keymaps
  vim.keymap.set('n', '<leader>lr', buf.rename, {})
  vim.keymap.set('n', '<leader>la', buf.code_action, {})
  vim.keymap.set('n', '<leader>lf', buf.format, {})
  vim.keymap.set('n', '<leader>ld', diagnostic.open_float)

  -- Definition & Implementation
  vim.keymap.set('n', 'gd', buf.definition, {})
  vim.keymap.set('n', 'K', buf.hover, {})
  vim.keymap.set('n', 'gi', telescope.lsp_implementations, {})
  vim.keymap.set('n', 'gr', telescope.lsp_references, {})

  -- Diagnostic navigation
  vim.keymap.set('n', '[d', diagnostic.goto_prev)
  vim.keymap.set('n', ']d', diagnostic.goto_next)
end

-- List of servers
local servers = { 'lua_ls', 'ts_ls', 'eslint', 'tailwindcss', 'html', 'prismals', "pyright" }

-- Server setup
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end
