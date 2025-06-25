_G.QuranAudio = {
  audio_path = vim.fn.expand("~/.config/nvim/lua/quran/audio/"),
  player_cmd = "mpv",
  player_args = { "--no-terminal", "--audio-display=no" },
  player_pid = nil -- To track the active player process
}

local surahs = {
  { name = "Al-Fatihah", number = 1 },
  { name = "Al-Baqarah", number = 2 },
  -- [rest of the 114 surahs...]
  { name = "An-Nas",     number = 114 }
}

local function stop_audio()
  if QuranAudio.player_pid then
    vim.fn.jobstop(QuranAudio.player_pid)
    QuranAudio.player_pid = nil
    print("⏹️ Stopped current playback")
  end
end

local function play_surah(surah_num)
  stop_audio() -- Stop any currently playing audio first

  local formatted_num = string.format("%03d", surah_num)
  local audio_file = QuranAudio.audio_path .. formatted_num .. ".mp3"

  if vim.fn.empty(vim.fn.glob(audio_file)) == 1 then
    print("❌ Audio file not found: " .. audio_file)
    return false
  end

  local args = { QuranAudio.player_cmd }
  for _, arg in ipairs(QuranAudio.player_args) do
    table.insert(args, arg)
  end
  table.insert(args, audio_file)

  QuranAudio.player_pid = vim.fn.jobstart(args, {
    detach = true,
    on_exit = function()
      QuranAudio.player_pid = nil
    end
  })

  if QuranAudio.player_pid <= 0 then
    print("❌ Failed to start playback")
    QuranAudio.player_pid = nil
    return false
  end

  return true
end

-- Enhanced FZF-Lua picker with fixed previewer
vim.api.nvim_create_user_command("QuranSurah", function()
  if not pcall(require, 'fzf-lua') then
    print("❌ fzf-lua not installed. Please install it with your package manager")
    return
  end

  local fzf = require('fzf-lua')
  local items = {}

  for _, surah in ipairs(surahs) do
    table.insert(items, string.format("%03d - %s", surah.number, surah.name))
  end

  fzf.fzf_exec(items, {
    prompt = "Surah❯ ",
    previewer = false,
    actions = {
      ["default"] = function(selected)
        if not selected or #selected == 0 then return end
        local surah_num = tonumber(selected[1]:match("^(%d+)"))
        if surah_num and play_surah(surah_num) then
          print(string.format("▶️ Playing: %03d - %s", surah_num, surahs[surah_num].name))
        end
      end,
    },
    fzf_opts = {
      ["--layout"] = "reverse",
      ["--border"] = "rounded",
      ["--info"] = "inline",
      ["--header"] = " Select Surah to Play ",
    }
  })
end, {})

-- Command to stop current playback
vim.api.nvim_create_user_command("QuranStop", stop_audio, {})

-- Stop audio when exiting Neovim
vim.api.nvim_create_autocmd("VimLeave", {
  callback = stop_audio
})

-- keymaps
vim.keymap.set('n', '<leader>pq', '<CMD>QuranSurah<CR>')
vim.keymap.set('n', '<leader>ps', '<CMD>QuranStop<CR>')
