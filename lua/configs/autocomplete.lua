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
    { name = 'orgmode' },
    { name = 'nvim_lsp', priority = 1000 }, -- Higher priority for LSP
    {
      name = 'buffer',
      option = {
        get_bufnrs = function()
          local buf = vim.api.nvim_get_current_buf()
          local byte_size = vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf))
          if byte_size > 1024 * 1024 then -- 1 Megabyte max
            return {}
          end
          return { buf }
        end,
      },
      priority = 500,
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
