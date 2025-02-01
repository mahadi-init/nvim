-- LSP config
local lspconfig = require 'lspconfig'
local capabilities = require('blink.cmp').get_lsp_capabilities()

local on_attach = function(_, _)
  local buf = vim.lsp.buf
  local diagnostic = vim.diagnostic

  -- LSP keymaps
  vim.keymap.set('n', '<leader>lr', buf.rename)
  vim.keymap.set('n', '<leader>la', ':Lspsaga code_action<CR>')
  vim.keymap.set('n', '<leader>ld', diagnostic.open_float)

  -- Definition & Implementation & calling
  vim.keymap.set('n', 'K', ':Lspsaga hover_doc<CR>')
  vim.keymap.set('n', 'gd', ':Lspsaga goto_definition<CR>')
  vim.keymap.set('n', 'gr', ':Lspsaga finder<CR>')
  vim.keymap.set('n', 'gi', ':Lspsaga incoming_calls<CR>')
  vim.keymap.set('n', 'go', ':Lspsaga outgoing_calls<CR>')

  -- Diagnostic navigation
  vim.keymap.set('n', '[d', ':Lspsaga diagnostic_jump_prev<CR>')
  vim.keymap.set('n', ']d', ':Lspsaga diagnostic_jump_next<CR>')
end

-- List of servers
local servers = { 'lua_ls', 'ts_ls', 'eslint', 'tailwindcss', 'html', 'cssls' }

-- Server setup
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end
