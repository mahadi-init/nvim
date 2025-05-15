return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  cmd = 'Telescope',
  keys = {
    { '<leader><leader>', '<cmd>Telescope find_files<cr>',                desc = 'Find files' },
    { '<C-g>',            '<cmd>Telescope git_status<cr>',                desc = 'Git status' },
    { '<leader>fw',       '<cmd>Telescope live_grep<cr>',                 desc = 'Find words' },
    { '<C-b>',            '<cmd>Telescope buffers<cr>',                   desc = 'Find buffer' },
    { '<leader>ft',       '<cmd>Telescope current_buffer_fuzzy_find<cr>', desc = 'Find text in current buffer' },
  },
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-tree/nvim-web-devicons' },
  },
  opts = {
    defaults = {
      path_display = {
        filename_first = {
          reverse_directories = true,
        },
      },
      prompt_prefix = '   ',
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
      cache_picker = {
        num_pickers = 5,
        limit_entries = 1000,
      },
    },
    pickers = {
      find_files = {
        find_command = { 'rg', '--files', '--sortr=modified' },
      },
      buffers = {
        sort_lastused = true,
        sort_mru = true,
      },
    },
  },
}
