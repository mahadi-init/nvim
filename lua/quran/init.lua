_G.QuranAudio = {
  audio_path = vim.fn.expand("~/.config/nvim/lua/quran/audio/"),
  player_cmd = "mpv",
  player_args = { "--no-terminal", "--audio-display=no" },
  player_pid = nil,   -- To track the active player process
  current_surah = nil -- Track currently playing surah
}

local surahs = {
  { name = "Al-Fatihah",    number = 1 },
  { name = "Al-Baqarah",    number = 2 },
  { name = "Aal-E-Imran",   number = 3 },
  { name = "An-Nisa",       number = 4 },
  { name = "Al-Ma'idah",    number = 5 },
  { name = "Al-An'am",      number = 6 },
  { name = "Al-A'raf",      number = 7 },
  { name = "Al-Anfal",      number = 8 },
  { name = "At-Tawbah",     number = 9 },
  { name = "Yunus",         number = 10 },
  { name = "Hud",           number = 11 },
  { name = "Yusuf",         number = 12 },
  { name = "Ar-Ra'd",       number = 13 },
  { name = "Ibrahim",       number = 14 },
  { name = "Al-Hijr",       number = 15 },
  { name = "An-Nahl",       number = 16 },
  { name = "Al-Isra",       number = 17 },
  { name = "Al-Kahf",       number = 18 },
  { name = "Maryam",        number = 19 },
  { name = "Ta-Ha",         number = 20 },
  { name = "Al-Anbiya",     number = 21 },
  { name = "Al-Hajj",       number = 22 },
  { name = "Al-Mu'minun",   number = 23 },
  { name = "An-Nur",        number = 24 },
  { name = "Al-Furqan",     number = 25 },
  { name = "Ash-Shu'ara",   number = 26 },
  { name = "An-Naml",       number = 27 },
  { name = "Al-Qasas",      number = 28 },
  { name = "Al-Ankabut",    number = 29 },
  { name = "Ar-Rum",        number = 30 },
  { name = "Luqman",        number = 31 },
  { name = "As-Sajdah",     number = 32 },
  { name = "Al-Ahzab",      number = 33 },
  { name = "Saba",          number = 34 },
  { name = "Fatir",         number = 35 },
  { name = "Ya-Sin",        number = 36 },
  { name = "As-Saffat",     number = 37 },
  { name = "Sad",           number = 38 },
  { name = "Az-Zumar",      number = 39 },
  { name = "Ghafir",        number = 40 },
  { name = "Fussilat",      number = 41 },
  { name = "Ash-Shura",     number = 42 },
  { name = "Az-Zukhruf",    number = 43 },
  { name = "Ad-Dukhan",     number = 44 },
  { name = "Al-Jathiyah",   number = 45 },
  { name = "Al-Ahqaf",      number = 46 },
  { name = "Muhammad",      number = 47 },
  { name = "Al-Fath",       number = 48 },
  { name = "Al-Hujurat",    number = 49 },
  { name = "Qaf",           number = 50 },
  { name = "Adh-Dhariyat",  number = 51 },
  { name = "At-Tur",        number = 52 },
  { name = "An-Najm",       number = 53 },
  { name = "Al-Qamar",      number = 54 },
  { name = "Ar-Rahman",     number = 55 },
  { name = "Al-Waqi'ah",    number = 56 },
  { name = "Al-Hadid",      number = 57 },
  { name = "Al-Mujadila",   number = 58 },
  { name = "Al-Hashr",      number = 59 },
  { name = "Al-Mumtahanah", number = 60 },
  { name = "As-Saff",       number = 61 },
  { name = "Al-Jumu'ah",    number = 62 },
  { name = "Al-Munafiqun",  number = 63 },
  { name = "At-Taghabun",   number = 64 },
  { name = "At-Talaq",      number = 65 },
  { name = "At-Tahrim",     number = 66 },
  { name = "Al-Mulk",       number = 67 },
  { name = "Al-Qalam",      number = 68 },
  { name = "Al-Haqqah",     number = 69 },
  { name = "Al-Ma'arij",    number = 70 },
  { name = "Nuh",           number = 71 },
  { name = "Al-Jinn",       number = 72 },
  { name = "Al-Muzzammil",  number = 73 },
  { name = "Al-Muddathir",  number = 74 },
  { name = "Al-Qiyamah",    number = 75 },
  { name = "Al-Insan",      number = 76 },
  { name = "Al-Mursalat",   number = 77 },
  { name = "An-Naba",       number = 78 },
  { name = "An-Nazi'at",    number = 79 },
  { name = "Abasa",         number = 80 },
  { name = "At-Takwir",     number = 81 },
  { name = "Al-Infitar",    number = 82 },
  { name = "Al-Mutaffifin", number = 83 },
  { name = "Al-Inshiqaq",   number = 84 },
  { name = "Al-Buruj",      number = 85 },
  { name = "At-Tariq",      number = 86 },
  { name = "Al-A'la",       number = 87 },
  { name = "Al-Gashiyah",   number = 88 },
  { name = "Al-Fajr",       number = 89 },
  { name = "Al-Balad",      number = 90 },
  { name = "Ash-Shams",     number = 91 },
  { name = "Al-Lail",       number = 92 },
  { name = "Ad-Duha",       number = 93 },
  { name = "Ash-Sharh",     number = 94 },
  { name = "At-Tin",        number = 95 },
  { name = "Al-Alaq",       number = 96 },
  { name = "Al-Qadr",       number = 97 },
  { name = "Al-Bayyinah",   number = 98 },
  { name = "Az-Zalzalah",   number = 99 },
  { name = "Al-Adiyat",     number = 100 },
  { name = "Al-Qari'ah",    number = 101 },
  { name = "At-Takathur",   number = 102 },
  { name = "Al-Asr",        number = 103 },
  { name = "Al-Humazah",    number = 104 },
  { name = "Al-Fil",        number = 105 },
  { name = "Quraish",       number = 106 },
  { name = "Al-Ma'un",      number = 107 },
  { name = "Al-Kawthar",    number = 108 },
  { name = "Al-Kafirun",    number = 109 },
  { name = "An-Nasr",       number = 110 },
  { name = "Al-Masad",      number = 111 },
  { name = "Al-Ikhlas",     number = 112 },
  { name = "Al-Falaq",      number = 113 },
  { name = "An-Nas",        number = 114 }
}

local function stop_audio()
  if QuranAudio.player_pid then
    vim.fn.jobstop(QuranAudio.player_pid)
    QuranAudio.player_pid = nil
    QuranAudio.current_surah = nil
    print("⏹️ Stopped current playback")
    -- Refresh lualine
    require('lualine').refresh()
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
      QuranAudio.current_surah = nil
      -- Refresh lualine when playback ends
      require('lualine').refresh()
    end
  })

  if QuranAudio.player_pid <= 0 then
    print("❌ Failed to start playback")
    QuranAudio.player_pid = nil
    return false
  end

  QuranAudio.current_surah = {
    number = surah_num,
    name = surahs[surah_num].name
  }

  -- Refresh lualine when starting new playback
  require('lualine').refresh()

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
