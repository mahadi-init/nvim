return {
  'fgheng/winbar.nvim',
  config = function()
    require('winbar').setup {
      enabled = true,

      show_file_path = true,
      show_symbols = true,

      colors = {
        path = '#FA8072', -- You can customize colors like #c946fd
        file_name = '#5F9EA0',
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
}
