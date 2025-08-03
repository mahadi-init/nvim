-- LSP config
local fzf = require 'fzf-lua'
local lspconfig = require 'lspconfig'
local capabilities = require('blink.cmp').get_lsp_capabilities()

local on_attach = function(client, bufnr)
  local buf = vim.lsp.buf
  local diagnostic = vim.diagnostic

  -- LSP keymaps
  Key('n', '<leader>lr', buf.rename)
  Key('n', '<leader>la', ':Lspsaga code_action<CR>')
  Key('n', '<leader>ld', diagnostic.open_float)

  -- Definition & Implementation & calling
  Key('n', 'K', ':Lspsaga hover_doc<CR>')
  Key('n', 'gd', ':Lspsaga goto_definition<CR>')
  Key('n', 'gr', ':Lspsaga finder<CR>')
  Key('n', 'gtr', fzf.lsp_references)

  -- Diagnostic navigation
  Key('n', '[d', ':Lspsaga diagnostic_jump_prev<CR>')
  Key('n', ']d', ':Lspsaga diagnostic_jump_next<CR>')
end

-- List of servers
local servers = {
  'lua_ls',
  'ts_ls',
  'eslint_d',
  'tailwindcss',
  'html',
  'cssls',
}

-- Server setup
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end
