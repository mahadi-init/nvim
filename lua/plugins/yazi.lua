return {
  'mikavilpas/yazi.nvim',
  event = 'VeryLazy',
  keys = {
    {
      '-',
      mode = { 'n', 'v' },
      '<cmd>Yazi<cr>',
      desc = 'Open yazi at the current file',
    },
  },
  opts = {
    open_for_directories = true,
    keymaps = {
      show_help = '<f1>',
    },
  },
  init = function()
    vim.g.loaded_netrwPlugin = 1

    Key('n', '<leader>e', function()
      local cwd = vim.fn.getcwd()
      local fd_cmd = 'fdfind --type d --hidden --exclude .git'
      local home = '󰣉 root/'

      -- Run the `fd` command to get folder list
      local fd_handle = io.popen(fd_cmd)
      local results = {}
      if fd_handle then
        for line in fd_handle:lines() do
          table.insert(results, line)
        end
        fd_handle:close()
      end

      -- Prepend "Home" (mapped to current root)
      table.insert(results, 1, home)

      require('fzf-lua').fzf_exec(results, {
        prompt = 'Select folder » ',
        cwd = cwd,
        file_icons = false,
        color_icons = false,
        git_icons = false,
        previewer = false,
        file_ignore_patterns = {
          '^.git/',
          'bun.lock',
          '^.gitignore$',
        },
        actions = {
          ['default'] = function(selected)
            if selected and selected[1] then
              local selected_path = selected[1]:match '^%s*(.-)%s*$'

              -- If "Home" selected, go to cwd (root)
              if selected_path == home then
                selected_path = '.'
              end

              local clean_path = vim.fn.fnamemodify(selected_path, ':p')
              require('yazi').yazi({}, clean_path)
            end
          end,
        },
      })
    end, { desc = 'Search & Open Folder in Yazi (fzf-lua)' })
  end,
}
