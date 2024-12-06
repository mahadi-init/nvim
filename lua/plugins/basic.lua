return {
  {
    'Raimondi/delimitMate',
    event = 'VeryLazy',
  },
  'nvim-treesitter/nvim-treesitter',
  {
    'lambdalisue/vim-fern',
    event = 'VeryLazy',
  },
  {
    'ellisonleao/gruvbox.nvim',
    priority = 1000,
    config = true,
    config = function()
      require('gruvbox').setup {
        terminal_colors = true,
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
        inverse = true,
        contrast = '',
        palette_overrides = {},
        overrides = {},
        dim_inactive = false,
        transparent_mode = false,
      }
      vim.cmd 'colorscheme gruvbox'
    end,
  },
  {
    'ibhagwan/fzf-lua',
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
    'williamboman/mason.nvim',
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
    event = 'BufReadPre',
    opts = {},
  },
  {
    'rachartier/tiny-inline-diagnostic.nvim',
    event = 'VeryLazy',
    priority = 1000,
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
    'kdheepak/lazygit.nvim',
    event = 'VeryLazy',
    cmd = {
      'LazyGit',
      'LazyGitConfig',
      'LazyGitCurrentFile',
      'LazyGitFilter',
      'LazyGitFilterCurrentFile',
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
  },
  {
    'akinsho/toggleterm.nvim',
    event = 'VeryLazy',
    version = '*',
    config = function()
      require('toggleterm').setup {
        direction = 'float',
        open_mapping = [[<c-k>]],
        start_in_insert = true,
        persist_size = true,
        close_on_exit = true,
        shell = vim.o.shell,
        hide_numbers = true,
        float_opts = {
          border = 'curved',
          winblend = 0,
          title_pos = 'center',
        },
      }
    end,
  },
}
