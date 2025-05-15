-- LSP config
local M = {}

M.setup = function()
  local lspconfig = require('lspconfig')

  -- Initialize capabilities lazily
  local capabilities = function()
    return require('blink.cmp').get_lsp_capabilities()
  end

  local on_attach = function(client, bufnr)
    local buf = vim.lsp.buf
    local diagnostic = vim.diagnostic

    -- LSP keymaps
    vim.keymap.set('n', '<leader>lr', buf.rename, { buffer = bufnr, desc = "LSP: Rename" })
    vim.keymap.set('n', '<leader>la', ':Lspsaga code_action<CR>', { buffer = bufnr, desc = "LSP: Code Action" })
    vim.keymap.set('n', '<leader>ld', diagnostic.open_float, { buffer = bufnr, desc = "LSP: Line Diagnostics" })

    -- Definition & Implementation & calling
    vim.keymap.set('n', 'K', ':Lspsaga hover_doc<CR>', { buffer = bufnr, desc = "LSP: Hover Doc" })
    vim.keymap.set('n', 'gd', ':Lspsaga goto_definition<CR>', { buffer = bufnr, desc = "LSP: Go to Definition" })
    vim.keymap.set('n', 'gr', ':Lspsaga finder<CR>', { buffer = bufnr, desc = "LSP: Find References" })
    vim.keymap.set('n', 'gtr', function() require('telescope.builtin').lsp_references() end,
      { buffer = bufnr, desc = "LSP: Telescope References" })
    vim.keymap.set('n', 'gi', ':Lspsaga incoming_calls<CR>', { buffer = bufnr, desc = "LSP: Incoming Calls" })
    vim.keymap.set('n', 'go', ':Lspsaga outgoing_calls<CR>', { buffer = bufnr, desc = "LSP: Outgoing Calls" })

    -- Diagnostic navigation
    vim.keymap.set('n', '[d', ':Lspsaga diagnostic_jump_prev<CR>', { buffer = bufnr, desc = "LSP: Previous Diagnostic" })
    vim.keymap.set('n', ']d', ':Lspsaga diagnostic_jump_next<CR>', { buffer = bufnr, desc = "LSP: Next Diagnostic" })
  end

  -- Server configurations with specific settings
  local servers = {
    lua_ls = {
      settings = {
        Lua = {
          diagnostics = { globals = { 'vim' } },
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
        },
      },
    },
    ts_ls = {},
    eslint = {},
    tailwindcss = {},
    html = {},
    cssls = {},
    prismals = {},
  }

  -- Server setup
  for server_name, server_config in pairs(servers) do
    server_config.on_attach = on_attach
    server_config.capabilities = capabilities()

    lspconfig[server_name].setup(server_config)
  end
end

return M
