return {
  'nvim-telescope/telescope.nvim',
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
}
