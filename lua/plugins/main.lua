return {
  {
    'Raimondi/delimitMate',
    event = 'VeryLazy',
  },
  {
    'nvim-treesitter/nvim-treesitter',
    event = 'VeryLazy',
  },
  {
    'hrsh7th/nvim-cmp',
    event = 'VeryLazy',
  },
  {
    'hrsh7th/cmp-nvim-lsp',
    event = 'VeryLazy',
  },
  {
    'onsails/lspkind.nvim',
    event = 'VeryLazy',
  },
  {
    'hrsh7th/cmp-buffer',
    event = 'VeryLazy',
  },
  {
    'moll/vim-bbye',
    event = 'VeryLazy',
  },
  {
    'williamboman/mason-lspconfig.nvim',
    event = 'VeryLazy',
    config = function()
      require('mason').setup {
        ensure_installed = {
          'lua_ls',
          'eslint-lsp',
          'prettierd',
          'prettier',
          'tailwindcss-language-server',
          'ts_ls',
          'html-lsp',
        },
      }
    end,
  },
  {
    'ellisonleao/gruvbox.nvim',
    priority = 1000,
    config = function()
      require('gruvbox').setup {
        terminal_colors = true,
        undercurl = true,
        underline = true,
        bold = true,
        italic = {
          strings = false,
          emphasis = false,
          comments = false,
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
  -- {
  --   'f-person/git-blame.nvim',
  --   event = 'VeryLazy',
  --   config = function()
  --     require('gitblame').setup {
  --       enabled = true,
  --       message_template = ' <summary> • <author> •  <date> ',
  --       date_format = '%I:%M %p %a, %d %b %Y',
  --       virtual_text_column = 1,
  --     }
  --   end,
  -- },
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
        open_mapping = [[<c-o>]],
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
  {
    'stevearc/dressing.nvim',
    event = 'VeryLazy',
    config = function()
      require('dressing').setup {
        input = {
          -- Set to false to disable the vim.ui.input implementation
          enabled = true,

          -- Default prompt string
          default_prompt = 'Input',

          -- Trim trailing `:` from prompt
          trim_prompt = true,

          -- Can be 'left', 'right', or 'center'
          title_pos = 'left',

          -- When true, input will start in insert mode.
          start_in_insert = true,

          -- These are passed to nvim_open_win
          border = 'rounded',
          -- 'editor' and 'win' will default to being centered
          relative = 'cursor',

          -- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
          prefer_width = 40,
          width = nil,
          -- min_width and max_width can be a list of mixed types.
          -- min_width = {20, 0.2} means "the greater of 20 columns or 20% of total"
          max_width = { 140, 0.9 },
          min_width = { 20, 0.2 },

          buf_options = {},
          win_options = {
            -- Disable line wrapping
            wrap = false,
            -- Indicator for when text exceeds window
            list = true,
            listchars = 'precedes:…,extends:…',
            -- Increase this for more context when text scrolls off the window
            sidescrolloff = 0,
          },

          -- Set to `false` to disable
          mappings = {
            n = {
              ['<Esc>'] = 'Close',
              ['<CR>'] = 'Confirm',
            },
            i = {
              ['<C-c>'] = 'Close',
              ['<CR>'] = 'Confirm',
              ['<Up>'] = 'HistoryPrev',
              ['<Down>'] = 'HistoryNext',
            },
          },

          override = function(conf)
            -- This is the config that will be passed to nvim_open_win.
            -- Change values here to customize the layout
            return conf
          end,

          -- see :help dressing_get_config
          get_config = nil,
        },
        select = {
          -- Set to false to disable the vim.ui.select implementation
          enabled = true,

          -- Priority list of preferred vim.select implementations
          backend = { 'fzf_lua', 'fzf', 'telescope', 'builtin', 'nui' },

          -- Trim trailing `:` from prompt
          trim_prompt = true,

          -- Options for telescope selector
          -- These are passed into the telescope picker directly. Can be used like:
          -- telescope = require('telescope.themes').get_ivy({...})
          telescope = nil,

          -- Options for fzf selector
          fzf = {
            window = {
              width = 0.5,
              height = 0.4,
            },
          },

          -- Options for fzf-lua
          fzf_lua = {
            winopts = {
              height = 0.5,
              width = 0.5,
            },
          },

          -- Options for nui Menu
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

          -- Options for built-in selector
          builtin = {
            -- Display numbers for options and set up keymaps
            show_numbers = true,
            -- These are passed to nvim_open_win
            border = 'rounded',
            -- 'editor' and 'win' will default to being centered
            relative = 'editor',

            buf_options = {},
            win_options = {
              cursorline = true,
              cursorlineopt = 'both',
            },

            -- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
            -- the min_ and max_ options can be a list of mixed types.
            -- max_width = {140, 0.8} means "the lesser of 140 columns or 80% of total"
            width = nil,
            max_width = { 140, 0.8 },
            min_width = { 40, 0.2 },
            height = nil,
            max_height = 0.9,
            min_height = { 10, 0.2 },

            -- Set to `false` to disable
            mappings = {
              ['<Esc>'] = 'Close',
              ['<C-c>'] = 'Close',
              ['<CR>'] = 'Confirm',
            },

            override = function(conf)
              -- This is the config that will be passed to nvim_open_win.
              -- Change values here to customize the layout
              return conf
            end,
          },

          -- Used to override format_item. See :help dressing-format
          format_item_override = {},

          -- see :help dressing_get_config
          get_config = nil,
        },
      }
    end,
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    event = 'VeryLazy',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
      {
        's1n7ax/nvim-window-picker',
        version = '2.*',
        config = function()
          require('window-picker').setup {
            filter_rules = {
              include_current_win = false,
              autoselect_one = true,
              -- filter using buffer options
              bo = {
                -- if the file type is one of following, the window will be ignored
                filetype = { 'neo-tree', 'neo-tree-popup', 'notify' },
                -- if the buffer type is one of following, the window will be ignored
                buftype = { 'terminal', 'quickfix' },
              },
            },
          }
        end,
      },
    },
    config = function()
      -- If you want icons for diagnostic errors, you'll need to define them somewhere:
      vim.fn.sign_define('DiagnosticSignError', { text = ' ', texthl = 'DiagnosticSignError' })
      vim.fn.sign_define('DiagnosticSignWarn', { text = ' ', texthl = 'DiagnosticSignWarn' })
      vim.fn.sign_define('DiagnosticSignInfo', { text = ' ', texthl = 'DiagnosticSignInfo' })
      vim.fn.sign_define('DiagnosticSignHint', { text = '󰌵', texthl = 'DiagnosticSignHint' })

      require('neo-tree').setup {
        close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
        popup_border_style = 'rounded',
        enable_git_status = true,
        enable_diagnostics = true,
        open_files_do_not_replace_types = { 'terminal', 'trouble', 'qf' }, -- when opening files, do not use windows containing these filetypes or buftypes
        sort_case_insensitive = false,                                     -- used when sorting files and directories in the tree
        sort_function = nil,                                               -- use a custom function for sorting files and directories in the tree
        -- sort_function = function (a,b)
        --       if a.type == b.type then
        --           return a.path > b.path
        --       else
        --           return a.type > b.type
        --       end
        --   end , -- this sorts files and directories descendantly
        default_component_configs = {
          container = {
            enable_character_fade = true,
          },
          indent = {
            indent_size = 2,
            padding = 1, -- extra padding on left hand side
            -- indent guides
            with_markers = true,
            indent_marker = '│',
            last_indent_marker = '└',
            highlight = 'NeoTreeIndentMarker',
            -- expander config, needed for nesting files
            with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
            expander_collapsed = '',
            expander_expanded = '',
            expander_highlight = 'NeoTreeExpander',
          },
          icon = {
            folder_closed = '',
            folder_open = '',
            folder_empty = '',
            provider = function(icon, node) -- default icon provider utilizes nvim-web-devicons if available
              if node.type == 'file' or node.type == 'terminal' then
                local success, web_devicons = pcall(require, 'nvim-web-devicons')
                local name = node.type == 'terminal' and 'terminal' or node.name
                if success then
                  local devicon, hl = web_devicons.get_icon(name)
                  icon.text = devicon or icon.text
                  icon.highlight = hl or icon.highlight
                end
              end
            end,
            -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
            -- then these will never be used.
            default = '*',
            highlight = 'NeoTreeFileIcon',
          },
          modified = {
            symbol = '',
            highlight = 'NeoTreeModified',
          },
          name = {
            trailing_slash = false,
            use_git_status_colors = true,
            highlight = 'NeoTreeFileName',
          },
          git_status = {
            symbols = {
              -- Change type
              added = '',    -- or "✚", but this is redundant info if you use git_status_colors on the name
              modified = '', -- or "", but this is redundant info if you use git_status_colors on the name
              deleted = '',  -- this can only be used in the git_status source
              renamed = '',  -- this can only be used in the git_status source
              -- Status type
              untracked = '',
              ignored = '',
              unstaged = '',
              staged = '',
              conflict = '',
            },
          },
          -- If you don't want to use these columns, you can set `enabled = false` for each of them individually
          file_size = {
            enabled = true,
            required_width = 64, -- min width of window required to show this column
          },
          type = {
            enabled = true,
            required_width = 122, -- min width of window required to show this column
          },
          last_modified = {
            enabled = true,
            required_width = 88, -- min width of window required to show this column
          },
          created = {
            enabled = true,
            required_width = 110, -- min width of window required to show this column
          },
          symlink_target = {
            enabled = false,
          },
        },
        -- A list of functions, each representing a global custom command
        -- that will be available in all sources (if not overridden in `opts[source_name].commands`)
        -- see `:h neo-tree-custom-commands-global`
        commands = {},
        window = {
          position = 'left',
          width = 35,
          mapping_options = {
            noremap = true,
            nowait = true,
          },
        },
        nesting_rules = {},
        filesystem = {
          filtered_items = {
            visible = false, -- when true, they will just be displayed differently than normal items
            hide_dotfiles = true,
            hide_gitignored = true,
            hide_hidden = true, -- only works on Windows for hidden files/directories
            hide_by_name = {
              'node_modules',
            },
            hide_by_pattern = { -- uses glob style patterns
              '*.meta',
              '*/src/*/tsconfig.json',
            },
            always_show = { -- remains visible even if other settings would normally hide it
              '.gitignored',
            },
            always_show_by_pattern = { -- uses glob style patterns
              '.env*',
            },
            never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
              '.DS_Store',
              'thumbs.db',
            },
            never_show_by_pattern = { -- uses glob style patterns
              '.null-ls_*',
            },
          },
          follow_current_file = {
            enabled = true,                   -- This will find and focus the file in the active buffer every time
            --               -- the current file is changed while the tree is open.
            leave_dirs_open = false,          -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
          },
          group_empty_dirs = false,           -- when true, empty folders will be grouped together
          hijack_netrw_behavior = 'disabled', -- netrw disabled, opening a directory opens neo-tree
          -- in whatever position is specified in window.position
          -- "open_current",  -- netrw disabled, opening a directory opens within the
          -- window like netrw would, regardless of window.position
          -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
          use_libuv_file_watcher = true, -- This will use the OS level file watchers to detect changes
          -- instead of relying on nvim autocmd events.
          window = {},
          commands = {}, -- Add a custom command or override a global one using the same function name
        },
        buffers = {
          follow_current_file = {
            enabled = true,          -- This will find and focus the file in the active buffer every time
            --              -- the current file is changed while the tree is open.
            leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
          },
          group_empty_dirs = true,   -- when true, empty folders will be grouped together
          show_unloaded = true,
          window = {},
        },
        git_status = {
          window = {
            position = 'float',
          },
        },
      }

      vim.cmd [[nnoremap \ :Neotree reveal<cr>]]
    end,
  },
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    keys = {
      {
        's',
        mode = { 'n', 'x', 'o' },
        function()
          require('flash').jump()
        end,
        desc = 'Flash',
      },
      {
        'S',
        mode = { 'n', 'x', 'o' },
        function()
          require('flash').treesitter()
        end,
        desc = 'Flash Treesitter',
      },
    },
  },
  {
    'folke/snacks.nvim',
    opts = {
      dashboard = {},
      bufDelete = {},
      git = {},
      lazygit = {},
      notifier = {},
      quickfile = {},
    },
  },
  {
    'nvim-pack/nvim-spectre',
    event = 'VeryLazy',
  },
  {
    'echasnovski/mini.tabline',
    event = 'VeryLazy',
    version = false,
    config = function()
      require('mini.tabline').setup()
    end,
  },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    event = 'VeryLazy',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    opts = {
      defaults = {
        path_display = {
          filename_first = {
            reverse_directories = true,
          },
        },
        layout_strategy = 'horizontal',
        layout_config = { prompt_position = 'top' },
        sorting_strategy = 'ascending',
        winblend = 0,
        preview = {
          -- hide_on_startup = true,
        },
        file_ignore_patterns = {
          'node_modules',
          '.next',
          'package-lock.json',
        },
      },
      pickers = {
        find_files = {
          find_command = { 'rg', '--files', '--sortr=modified' },
        },
      },
    },
  },
  {
    'antosha417/nvim-lsp-file-operations',
    event = 'VeryLazy',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-neo-tree/neo-tree.nvim',
    },
    config = function()
      require('lsp-file-operations').setup()
    end,
  },
  {
    'sindrets/diffview.nvim',
    event = "VeryLazy"
  },
  {
    'prisma/vim-prisma',
    event = "VeryLazy"
  },
  {
    'stevearc/oil.nvim',
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
    opts = {},
    config = function()
      require("oil").setup()
    end
  }
}
