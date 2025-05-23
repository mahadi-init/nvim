return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  event = 'VeryLazy',
  opts = {
    defaults = {
      path_display = {
        filename_first = {
          reverse_directories = true,
        },
      },
      prompt_prefix = '   ',
      selection_caret = ' ❯ ',
      layout_strategy = 'horizontal',
      layout_config = { prompt_position = 'top' },
      sorting_strategy = 'ascending',
      winblend = 0,
      file_ignore_patterns = {
        'node_modules',
        '.next',
        'package-lock.json',
        'bun.lock',
        'pnpm-lock.yaml',
        '%.svg$', -- This will ignore files ending with .svg
      },
    },
    pickers = {
      find_files = {
        find_command = { 'rg', '--files', '--sortr=modified' },
      },
    },
  },
}
