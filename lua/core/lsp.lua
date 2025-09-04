-- LSP config
local lspconfig = require 'lspconfig'
local capabilities = require('blink.cmp').get_lsp_capabilities()

local on_attach = function()
  local buf = vim.lsp.buf
  local diagnostic = vim.diagnostic

  -- LSP keymaps
  Key('n', '<leader>lr', buf.rename)
  Key('n', '<leader>la', buf.code_action)
  Key('n', '<leader>ld', diagnostic.open_float)
  Key('n', 'K', buf.hover)
  Key('n', 'gd', buf.definition)
  Key('n', 'gr', function()
    Snacks.picker.lsp_references()
  end)
  Key('n', '[d', diagnostic.goto_prev)
  Key('n', ']d', diagnostic.goto_next)
end

-- List of servers
local servers = {
  'lua_ls',
  'ts_ls',
  'eslint',
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
