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

  -- Definition & Implementation & calling
  Key('n', 'K', function()
    Snacks.hover()
  end)
  Key('n', 'gr', buf.references)
  Key('n', 'gtr', function()
    Snacks.picker.lsp_references()
  end)

  -- Diagnostic navigation
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
