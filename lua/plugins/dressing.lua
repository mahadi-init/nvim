return {
  'stevearc/dressing.nvim',
  event = 'VeryLazy',
  config = function()
    require('dressing').setup {
      input = {
        enabled = true,
        default_prompt = 'Input',
        trim_prompt = true,
        title_pos = 'left',
        start_in_insert = true,
        border = 'rounded',
        relative = 'cursor',
        prefer_width = 40,
        width = nil,
        max_width = { 140, 0.9 },
        min_width = { 20, 0.2 },
        buf_options = {},
        win_options = {
          wrap = false,
          list = true,
          listchars = 'precedes:…,extends:…',
          sidescrolloff = 0,
        },
        mappings = {
          n = {
            ['<Esc>'] = 'Close',
            ['<CR>'] = 'Confirm',
          },
          i = {
            ['<CR>'] = 'Confirm',
          },
        },
        override = function(conf)
          return conf
        end,

        get_config = nil,
      },
      select = {
        enabled = true,
        backend = { 'fzf_lua', 'fzf', 'telescope', 'builtin', 'nui' },
        trim_prompt = true,
        telescope = nil,
        fzf = {
          window = {
            width = 0.5,
            height = 0.4,
          },
        },
        fzf_lua = {
          winopts = {
            height = 0.5,
            width = 0.5,
          },
        },
        nui = {
          position = '50%',
          size = nil,
          relative = 'editor',
          border = {
            style = 'rounded',
          },
          buf_options = {
            swapfile = false,
            filetype = 'DressingSelect',
          },
          win_options = {
            winblend = 0,
          },
          max_width = 80,
          max_height = 40,
          min_width = 40,
          min_height = 10,
        },
        builtin = {
          show_numbers = true,
          border = 'rounded',
          relative = 'editor',
          buf_options = {},
          win_options = {
            cursorline = true,
            cursorlineopt = 'both',
          },
          width = nil,
          max_width = { 140, 0.8 },
          min_width = { 40, 0.2 },
          height = nil,
          max_height = 0.9,
          min_height = { 10, 0.2 },
          mappings = {
            ['<Esc>'] = 'Close',
            ['<CR>'] = 'Confirm',
          },
          override = function(conf)
            return conf
          end,
        },
        format_item_override = {},
        get_config = nil,
      },
    }
  end,
}
