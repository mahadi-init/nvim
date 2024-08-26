require('mason').setup()
require('mason-lspconfig').setup()
local builtin = require 'telescope.builtin'

local on_attach = function(_, _)
  local buf = vim.lsp.buf
  local diagnostic = vim.diagnostic

  -- lsp keymaps
  vim.keymap.set('n', '<leader>lr', buf.rename, {})
  vim.keymap.set('n', '<leader>la', buf.code_action, {})
  vim.keymap.set('n', '<leader>lf', buf.format, {})
  vim.keymap.set('n', '<leader>ld', diagnostic.open_float)

  -- definition & implementation
  vim.keymap.set('n', 'gd', buf.definition, {})
  vim.keymap.set('n', 'gi', buf.implementation, {})
  vim.keymap.set('n', 'gr', builtin.lsp_references, {})
  vim.keymap.set('n', 'K', buf.hover, {})

  -- diagnostic
  vim.keymap.set('n', '[d', diagnostic.goto_prev)
  vim.keymap.set('n', ']d', diagnostic.goto_next)
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()
local config = require 'lspconfig'
local servers = { 'lua_ls', 'tsserver', 'eslint', 'tailwindcss', 'html' }

for _, lsp in ipairs(servers) do
  config[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end
