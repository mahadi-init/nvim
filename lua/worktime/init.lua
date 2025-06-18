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

local function get_project_name()
  return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
end

local function get_log_path()
  return vim.fn.stdpath("data") .. "/worktime/" .. get_project_name() .. ".txt"
end

local function get_cache_path()
  return vim.fn.stdpath("data") .. "/worktime/" .. get_project_name() .. ".cache"
end

function M.add_session(time_start, time_end)
  local duration = time_end - time_start
  local log_line = string.format("%d,%d,%d\n", time_start, time_end, duration)

  -- append to log
  local log_path = get_log_path()
  vim.fn.mkdir(vim.fn.fnamemodify(log_path, ":h"), "p")
  local f = io.open(log_path, "a")
  if f then
    f:write(log_line)
    f:close()
  end

  -- update cache
  local cache_path = get_cache_path()
  local cached = 0
  local fc = io.open(cache_path, "r")
  if fc then
    ---@diagnostic disable-next-line: cast-local-type
    cached = tonumber(fc:read("*l") or "0")
    fc:close()
  end

  cached = cached + duration
  local fw = io.open(cache_path, "w")
  if fw then
    fw:write(tostring(cached))
    fw:close()
  end
end

function M.print_total_time()
  local cache_path = get_cache_path()
  local total = 0
  local f = io.open(cache_path, "r")
  if f then
    ---@diagnostic disable-next-line: cast-local-type
    total = tonumber(f:read("*l") or "0")
    f:close()
  end

  local hours = math.floor(total / 3600)
  local minutes = math.floor((total % 3600) / 60)
  if hours > 0 then
    vim.notify(string.format("⏱  Total time on %s:%2dh %2dm", project_name, hours, minutes), vim.log.levels.INFO)
  else
    vim.notify(string.format("⏱  Total time on %s: %2dm", project_name, minutes), vim.log.levels.INFO)
  end
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

function M.get_cached_total_formatted()
  local cache_path = get_cache_path()

  local file = io.open(cache_path, "r")
  if not file then
    return "0m"
  end

  local total_seconds = tonumber(file:read("*a")) or 0
  file:close()

  local hours = math.floor(total_seconds / 3600)
  local minutes = math.floor((total_seconds % 3600) / 60)

  if hours > 0 then
    return string.format("%dh %02dm", hours, minutes)
  else
    return string.format("%dm", minutes)
  end
end

return M
