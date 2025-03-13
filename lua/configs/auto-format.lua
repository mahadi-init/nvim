-- sort_imports.lua

local M = {}

-- Function to sort imports by line length
local function sort_imports()
  -- Get the current buffer
  local buf = vim.api.nvim_get_current_buf()

  -- Get all lines in the buffer
  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)

  -- Find the start and end of the import block
  local import_start, import_end = nil, nil
  for i, line in ipairs(lines) do
    if line:match '^import' then
      import_start = import_start or i
      import_end = i
    end
  end

  -- If no imports found, return
  if not import_start or not import_end then
    return
  end

  -- Extract the import lines
  local imports = {}
  for i = import_start, import_end do
    table.insert(imports, lines[i])
  end

  -- Sort imports by line length
  table.sort(imports, function(a, b)
    return #a < #b
  end)

  -- Replace the import lines in the buffer
  for i = import_start, import_end do
    lines[i] = imports[i - import_start + 1]
  end

  -- Update the buffer with the sorted lines
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
end

-- Function to setup the plugin
function M.setup()
  -- Create an autocommand to sort imports on save
  vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = '*.js,*.jsx,*.ts,*.tsx', -- Adjust file types as needed
    callback = sort_imports,
  })
end

return M
