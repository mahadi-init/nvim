-- utility functions for the neovim configuration
local M = {}

-- Helper function for easier keymap creation
-- @param mode string|table: Mode or modes to set keymap for
-- @param lhs string: Left-hand side of the mapping
-- @param rhs string|function: Right-hand side of the mapping
-- @param opts table|nil: Optional parameters
M.map = function(mode, lhs, rhs, opts)
  opts = opts or {}
  -- Set sensible defaults
  if opts.silent == nil then opts.silent = true end
  if opts.noremap == nil then opts.noremap = true end

  vim.keymap.set(mode, lhs, rhs, opts)
end

-- Function to create multiple keymaps at once
-- @param maps table: Table of mapping definitions
M.create_maps = function(maps)
  for _, mapping in ipairs(maps) do
    local mode, lhs, rhs, opts = unpack(mapping)
    M.map(mode, lhs, rhs, opts)
  end
end

-- Safely require a module with fallback
-- @param module string: Module name to require
-- @param fallback any: Fallback value if require fails
-- @return any: The required module or the fallback
M.safe_require = function(module, fallback)
  local ok, result = pcall(require, module)
  if not ok then
    return fallback
  end
  return result
end

-- Check if a file exists
-- @param file string: Path to file
-- @return boolean: True if file exists, false otherwise
M.file_exists = function(file)
  local f = io.open(file, "r")
  if f then f:close() end
  return f ~= nil
end

-- Debounce a function call
-- @param func function: Function to debounce
-- @param timeout number: Debounce timeout in ms
-- @return function: Debounced function
M.debounce = function(func, timeout)
  local timer = vim.loop.new_timer()
  return function(...)
    local args = { ... }
    timer:stop()
    timer:start(timeout, 0, function()
      vim.schedule(function()
        func(unpack(args))
      end)
    end)
  end
end

return M

