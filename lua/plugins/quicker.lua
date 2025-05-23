return {
  'stevearc/quicker.nvim',
  event = 'FileType qf',
  opts = {},
  config = function()
    require('quicker').setup {
      opts = {
        buflisted = false,
        number = false,
        relativenumber = false,
        signcolumn = 'auto',
        winfixheight = true,
        wrap = false,
      },
      use_default_opts = true,
      on_qf = function() end,
      edit = {
        enabled = true,
        autosave = 'unmodified',
      },
      constrain_cursor = true,
      highlight = {
        treesitter = true,
        lsp = true,
        load_buffers = false,
      },
      follow = {
        enabled = false,
      },
      type_icons = {
        E = '󰅚 ',
        W = '󰀪 ',
        I = ' ',
        N = ' ',
        H = ' ',
      },
      borders = {
        vert = '┃',
        strong_header = '━',
        strong_cross = '╋',
        strong_end = '┫',
        soft_header = '╌',
        soft_cross = '╂',
        soft_end = '┨',
      },
      trim_leading_whitespace = 'common',
      max_filename_width = function()
        return math.floor(math.min(95, vim.o.columns / 2))
      end,
      header_length = function(type, start_col)
        return vim.o.columns - start_col
      end,
    }
  end,
}
