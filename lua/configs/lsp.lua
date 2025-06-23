-- LSP config
local lspconfig = require 'lspconfig'
local fzf = require("fzf-lua")
local capabilities = require('blink.cmp').get_lsp_capabilities()

local on_attach = function(client, bufnr)
  local buf = vim.lsp.buf
  local diagnostic = vim.diagnostic
  local bufopts = { noremap = true, silent = true, buffer = bufnr }

  -- LSP keymaps
  vim.keymap.set('n', '<leader>lr', buf.rename)
  vim.keymap.set('n', '<leader>la', ':Lspsaga code_action<CR>')
  vim.keymap.set('n', '<leader>ld', diagnostic.open_float)

  -- Definition & Implementation & calling
  vim.keymap.set('n', 'K', ':Lspsaga hover_doc<CR>')
  vim.keymap.set('n', 'gd', ':Lspsaga goto_definition<CR>')
  vim.keymap.set('n', 'gr', ':Lspsaga finder<CR>')
  vim.keymap.set('n', 'gtr', fzf.lsp_references)
  vim.keymap.set('n', 'gi', ':Lspsaga incoming_calls<CR>')
  vim.keymap.set('n', 'go', ':Lspsaga outgoing_calls<CR>')

  -- Diagnostic navigation
  vim.keymap.set('n', '[d', ':Lspsaga diagnostic_jump_prev<CR>')
  vim.keymap.set('n', ']d', ':Lspsaga diagnostic_jump_next<CR>')

  -- TypeScript specific keymaps
  if client.name == 'ts_ls' then
    -- Modern implementation of organize imports
    vim.keymap.set('n', '<C-f>', function()
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
local servers = { 'lua_ls', 'ts_ls', 'eslint', 'tailwindcss', 'html', 'cssls', 'prismals' }

-- Server setup
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end
