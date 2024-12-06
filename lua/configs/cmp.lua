-- Import necessary modules
local cmp = require 'cmp'
local lspkind = require 'lspkind'
local cmp_buffer = require 'cmp_buffer'

-- nvim-cmp setup
cmp.setup {
  mapping = cmp.mapping.preset.insert {
    ['<CR>'] = cmp.mapping.confirm { select = true },
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<Tab>'] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },
  },
  sources = cmp.config.sources {
    { name = 'nvim_lsp' }, -- Higher priority for LSP
    {
      name = 'buffer',
      option = {
        get_bufnrs = function()
          local bufs = {}
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            bufs[vim.api.nvim_win_get_buf(win)] = true
          end
          return vim.tbl_keys(bufs)
        end,
      },
    },
    sorting = {
      comparators = {
        function(...)
          return cmp_buffer:compare_locality(...)
        end,
      },
    },
  },
  formatting = {
    format = lspkind.cmp_format {
      mode = 'symbol_text',
      maxwidth = 50,
      ellipsis_char = '...',
      show_labelDetails = true,
      before = function(_, vim_item)
        return vim_item
      end,
    },
  },
}
