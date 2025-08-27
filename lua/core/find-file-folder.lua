local function files_and_folders()
  local fd_cmd = 'fdfind --type f --type d --hidden --exclude .git'
  local fd_handle = io.popen(fd_cmd)
  local results = {}

  if fd_handle then
    for line in fd_handle:lines() do
      local abs_path = vim.fn.fnamemodify(line, ':p')
      local display
      if vim.fn.isdirectory(abs_path) == 1 then
        display = '📁 ' .. line .. '/' -- mark as folder
      else
        display = '📄 ' .. line -- mark as file
      end
      table.insert(results, { path = abs_path, display = display })
    end
    fd_handle:close()
  end

  -- add project root (cwd) at the very top
  local cwd = vim.fn.getcwd()
  table.insert(results, 1, {
    path = cwd,
    display = '📂 root', -- different icon for clarity
  })

  vim.ui.select(results, {
    prompt = 'Files and Folders:',
    format_item = function(item)
      return item.display
    end,
  }, function(selected)
    if not selected then
      return
    end

    if vim.fn.isdirectory(selected.path) == 1 then
      require('yazi').yazi({}, selected.path)
    else
      vim.cmd('edit ' .. selected.path)
    end
  end)
end

vim.keymap.set('n', '<leader><leader>', files_and_folders, { desc = 'Files & Folders (Yazi compatible)' })
