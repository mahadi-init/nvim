-- LSP config
local fzf = require 'fzf-lua'
local lspconfig = require 'lspconfig'
local capabilities = require('blink.cmp').get_lsp_capabilities()

local on_attach = function(client, bufnr)
  local buf = vim.lsp.buf
  local diagnostic = vim.diagnostic
  local bufopts = { noremap = true, silent = true, buffer = bufnr }

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

  -- TypeScript specific keymaps
  if client.name == 'ts_ls' then
    Key('n', '<C-f>', function()
      client.request('workspace/executeCommand', {
        command = '_typescript.organizeImports',
        arguments = { vim.api.nvim_buf_get_name(0) },
      }, function(err)
        if err then
          vim.notify('Error organizing imports: ' .. err.message, vim.log.levels.ERROR)
        end
      end, bufnr)
    end, vim.tbl_extend('keep', bufopts, { desc = 'Organize imports' }))
  end
end

-- List of servers
local servers = {
  'lua_ls',
  'ts_ls',
  'eslint',
  'tailwindcss',
  'html',
  'cssls',
  'prismals',
  'ruff',
  'dockerls',
  'docker_compose_language_service',
}

lspconfig.pyright.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    python = {
      analysis = {
        typeCheckingMode = 'off',
        autoSearchPaths = true,
        autoImportCompletions = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = 'workspace',
      },
    },
  },
}

-- Server setup
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end
