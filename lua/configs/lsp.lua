-- LSP config
local lspconfig = require 'lspconfig'
local capabilities = require('cmp_nvim_lsp').default_capabilities()

local on_attach = function(_, _)
  local buf = vim.lsp.buf

  -- LSP keymaps
  vim.keymap.set('n', '<leader>lr', buf.rename)
  vim.keymap.set('n', '<leader>la', ':Lspsaga code_action<CR>')

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
local servers = { 'lua_ls', 'ts_ls', 'eslint', 'tailwindcss', 'html', 'prismals' }

-- Server setup
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end
