local worktime = require("worktime")

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
