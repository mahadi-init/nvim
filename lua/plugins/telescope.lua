return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  event = 'VeryLazy',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('telescope').setup {
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
    }
    local telescope = require 'telescope.builtin'

    -- Key mappings should be outside the setup function
    vim.keymap.set('n', '<leader><leader>', telescope.find_files, { desc = 'find files' }) -- find files
    vim.keymap.set('n', '<C-g>', telescope.git_status, { desc = 'git status' })            -- git status
    vim.keymap.set('n', '<leader>fw', telescope.live_grep, { desc = 'find words' })        -- live grep
    vim.keymap.set('n', '<C-b>', telescope.buffers, { desc = 'Find buffer' })
    vim.keymap.set('n', '<leader>ft', telescope.current_buffer_fuzzy_find, { desc = 'find text current buffer' })
    vim.keymap.set('n', '<leader>fm', telescope.marks, { desc = 'marks' })
  end,
}
