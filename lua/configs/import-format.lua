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
  local imports = {}
  local current_import = {}

  for i, line in ipairs(lines) do
    -- Check if the line starts with "import"
    if line:match '^import' then
      -- If we're already collecting an import, add it to the imports table
      if #current_import > 0 then
        table.insert(imports, current_import)
        current_import = {}
      end
      import_start = import_start or i
      import_end = i
      table.insert(current_import, line)
    elseif line:match '^%s*[%w{},]' and #current_import > 0 then
      -- If the line is part of a multi-line import, add it to the current import
      table.insert(current_import, line)
      import_end = i
    elseif #current_import > 0 then
      -- If we were collecting an import and the current line doesn't belong to it, finalize the import
      table.insert(imports, current_import)
      current_import = {}
    end
  end

  -- Add the last import if it exists
  if #current_import > 0 then
    table.insert(imports, current_import)
  end

  -- If no imports found, return
  if #imports == 0 then
    return
  end

  -- Sort imports: multi-line imports first, then by total length
  table.sort(imports, function(a, b)
    local a_is_multi = #a > 1
    local b_is_multi = #b > 1

    -- Prioritize multi-line imports
    if a_is_multi and not b_is_multi then
      return true
    elseif not a_is_multi and b_is_multi then
      return false
    end

    -- If both are multi-line or both are single-line, sort by total length
    return #table.concat(a, '\n') < #table.concat(b, '\n')
  end)

  -- Replace the import lines in the buffer
  local new_lines = {}
  local import_index = 1
  for i, line in ipairs(lines) do
    if i < import_start or i > import_end then
      -- Add non-import lines as-is
      table.insert(new_lines, line)
    elseif import_index <= #imports then
      -- Add sorted imports (flatten multi-line imports into individual lines)
      for _, import_line in ipairs(imports[import_index]) do
        table.insert(new_lines, import_line)
      end
      import_index = import_index + 1
    end
  end

  -- Update the buffer with the sorted lines
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, new_lines)
end

-- Function to setup the plugin
function M.setup()
  -- Expose a command for manual sorting
  vim.api.nvim_create_user_command('SortImports', sort_imports, {})
end

return M
