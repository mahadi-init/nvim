local M = {}

local start_time = nil
local work_dir = vim.fn.getcwd()
local project_name = vim.fn.fnamemodify(work_dir, ":t")
local data_dir = vim.fn.stdpath("data") .. "/worktime/"
local session_start_time = nil

-- Make sure data directory exists
local function ensure_data_dir()
  if vim.fn.isdirectory(data_dir) == 0 then
    vim.fn.mkdir(data_dir, "p")
  end
end

-- File path for this project
local function get_project_file()
  ensure_data_dir()
  return data_dir .. project_name .. ".txt"
end

-- Start timer
function M.start_timer()
  start_time = os.time()
end

-- Stop timer and save
function M.stop_timer()
  if not start_time then return end

  local end_time = os.time()
  local duration = end_time - start_time
  local file = io.open(get_project_file(), "a")
  if file then
    file:write(string.format("%d,%d,%d\n", start_time, end_time, duration))
    file:close()
  end
end

function M.print_total_time()
  local file = io.open(get_project_file(), "r")
  if not file then
    return "No work sessions found for project: " .. project_name
  end

  local total = 0
  for line in file:lines() do
    local _, _, duration = line:match("(%d+),(%d+),(%d+)")
    if duration then
      total = total + tonumber(duration)
    end
  end
  file:close()

  return string.format("⏱  Total time on %s: %d minutes", project_name, math.floor(total / 60))
end

-- Called on VimEnter
function M.start_session()
  session_start_time = os.time()
end

-- Returns elapsed time since session start (as string)
function M.get_session_elapsed()
  if not session_start_time then return "🕒 00:00" end

  local elapsed = os.time() - session_start_time
  local mins = math.floor(elapsed / 60)
  local secs = elapsed % 60
  return string.format("🕒 %02d:%02d", mins, secs)
end

return M
