return {
  'mikavilpas/yazi.nvim',
  event = 'VeryLazy',
  dependencies = {
    'nvim-lua/plenary.nvim',
    lazy = true,
    event = 'VeryLazy',
  },
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
  },
  init = function()
    vim.g.loaded_netrwPlugin = 1

    Key('n', '<C-a>', function()
      local fd_cmd = 'fdfind --type d --hidden --exclude .git'

      -- Run the `fd` command to get folder list
      local fd_handle = io.popen(fd_cmd)
      local results = {}
      if fd_handle then
        for line in fd_handle:lines() do
          table.insert(results, line)
        end
        fd_handle:close()
      end

      local cwd = vim.fn.getcwd()
      table.insert(results, 1, cwd)

      vim.ui.select(results, {
        prompt = 'Select directory to open in Yazi:',
        format_item = function(item)
          -- Show relative path if it's shorter, otherwise show full path
          local relative = vim.fn.fnamemodify(item, ':.')
          return (#relative < #item) and relative or item
        end,
      }, function(selected)
        if selected then
          -- Convert to absolute path
          local abs_path = vim.fn.fnamemodify(selected, ':p')

          -- Verify directory still exists
          if vim.fn.isdirectory(abs_path) == 1 then
            require('yazi').yazi({}, abs_path)
          else
            vim.notify('Directory no longer exists: ' .. abs_path, vim.log.levels.ERROR)
          end
        end
      end)
    end, { desc = 'Search & Open Folder in Yazi' })
  end,
}
