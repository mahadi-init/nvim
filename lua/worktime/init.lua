local M = {}

local session_start_time = nil

-- Called on VimEnter
function M.start_session()
  session_start_time = os.time()
end

-- Returns elapsed time since session start (as string)
function M.get_session_elapsed()
  if not session_start_time then
    return '🕒 00:00'
  end

  local elapsed = os.time() - session_start_time
  local mins = math.floor(elapsed / 60)
  local secs = elapsed % 60
  return string.format('🕒 %02d:%02d', mins, secs)
end

return M
