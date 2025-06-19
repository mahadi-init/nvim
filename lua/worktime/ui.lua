local worktime = require("worktime")

-- Get greeting
local hour = tonumber(os.date("%H"))
local greeting = "🌃 Good night"
if hour >= 5 and hour < 12 then
  greeting = "🌅 Good morning"
elseif hour >= 12 and hour < 18 then
  greeting = "☀️ Good afternoon"
elseif hour >= 18 and hour < 21 then
  greeting = "🌇 Good evening"
end

-- Get date/time & worktime info
local date = os.date("📅 %A, %d %B %Y")
local time = os.date("⏰ %I:%M %p")
local total = worktime.get_cached_total_formatted()

return {
  config = {
    header = {
      "", "", "", "", "", "", "", -- padding
      "███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
      "████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
      "██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
      "██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
      "██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
      "╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
      "",
    },
    center = {
      { icon = "📊 ", desc = "" .. total, action = "" },
      { icon = "", desc = time, action = "" },
      { icon = "", desc = greeting, action = "" },
      { icon = "", desc = date, action = "" },
    },

    -- Optional UI tweaks:
    disable_move = false,
  },
  hide = {
    statusline = true,
    tabline = true,
    winbar = true,
  },
}
