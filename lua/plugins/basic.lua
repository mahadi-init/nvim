return {
  {
    'Raimondi/delimitMate', -- Auto close brackes and parenthesis
    event = 'VeryLazy',
  },
  'nvim-treesitter/nvim-treesitter', -- syntax highlighting
  {
    'lambdalisue/vim-fern', -- file tree
    event = 'VeryLazy',
  },
  {
    'ellisonleao/gruvbox.nvim',
    priority = 1000,
    config = true,
    config = function()
      -- Default options:
      require('gruvbox').setup {
        terminal_colors = true, -- add neovim terminal colors
        undercurl = true,
        underline = true,
        bold = true,
        italic = {
          strings = false,
          emphasis = false,
          comments = true,
          operators = false,
          folds = false,
        },
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        invert_intend_guides = false,
        inverse = true, -- invert background for search, diffs, statuslines and errors
        contrast = '', -- can be "hard", "soft" or empty string
        palette_overrides = {},
        overrides = {},
        dim_inactive = false,
        transparent_mode = false,
      }
      vim.cmd 'colorscheme gruvbox'
    end,
  },
  {
    'ibhagwan/fzf-lua', -- fzf searching
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('fzf-lua').setup {
        defaults = {
          git_icons = false,
          file_icons = false,
          color_icons = false,
        },
      }
    end,
  },
  {
    'williamboman/mason.nvim', --MASON
    event = 'VeryLazy',
    dependencies = {
      'neovim/nvim-lspconfig',
    },
    config = function()
      require('mason').setup {
        ui = {
          icons = {
            package_installed = '✓',
            package_pending = '➜',
            package_uninstalled = '✗',
          },
        },
      }
    end,
  },
  {
    'stevearc/conform.nvim', --CONFORM
    event = 'VeryLazy',
    config = function()
      require('conform').setup {
        formatters_by_ft = {
          lua = { 'stylua' },
          javascript = {
            'prettierd',
          },
          typescript = {
            'prettierd',
          },
          typescriptreact = {
            'prettierd',
          },
          html = {
            'prettierd',
          },
          css = {
            'prettierd',
          },
        },
        format_after_save = {
          lsp_format = 'fallback',
        },
      }
      require('conform').format()
    end,
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    event = 'VeryLazy',
    config = function()
      require('ibl').setup {
        scope = { enabled = false },
        exclude = {
          filetypes = {},
        },
      }
    end,
  },
  {
    'folke/persistence.nvim',
    event = 'BufReadPre', -- this will only start session saving when an actual file was opened,
    opts = {},
  },
  {
    'rachartier/tiny-inline-diagnostic.nvim',
    event = 'VeryLazy', -- Or `LspAttach`
    priority = 1000, -- needs to be loaded in first
    config = function()
      require('tiny-inline-diagnostic').setup {
        present = 'classic',
      }
    end,
  },
  {
    'f-person/git-blame.nvim',
    event = 'VeryLazy',
    config = function()
      require('gitblame').setup {
        enabled = true,
        message_template = ' <summary> • <author> •  <date> ',
        date_format = '%I:%M %p %a, %d %b %Y',
        virtual_text_column = 1,
      }
    end,
  },
  {
    'windwp/nvim-ts-autotag',
    event = 'VeryLazy',
    config = function()
      require('nvim-ts-autotag').setup {
        opts = {
          enable_close = true,
          enable_rename = true,
          enable_close_on_slash = true,
        },
      }
    end,
  },
  {
    'fgheng/winbar.nvim',
    event = 'VeryLazy',
    config = function()
      require('winbar').setup {
        enabled = true,
        show_file_path = true,
        show_symbols = true,

        colors = {
          path = '#FA8072', -- You can customize colors like #c946fd
          file_name = '#2bb0b2',
          symbols = '',
        },

        icons = {
          file_icon_default = '',
          seperator = '',
          editor_state = '●',
          lock_icon = '',
        },

        exclude_filetype = {
          'help',
          'startify',
          'dashboard',
          'packer',
          'neogitstatus',
          'NvimTree',
          'Trouble',
          'alpha',
          'lir',
          'Outline',
          'spectre_panel',
          'toggleterm',
          'qf',
          'neo-tree',
          'lazygit',
        },
      }
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    enabled = true,
    event = 'VeryLazy',
    config = function()
      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = 'gruvbox',
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
          disabled_filetypes = {
            -- statusline = { 'startify', 'netrw' },
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = true,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          },
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = {
            'branch',
          }, -- Added git diff
          lualine_c = { 'diagnostics' },
          lualine_x = { 'lsp_progress', 'diff' },
          lualine_y = { 'filetype' },
          lualine_z = { 'location', 'progress' },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { 'filename' },
          lualine_x = { 'location' },
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {},
      }
    end,
  },
}
