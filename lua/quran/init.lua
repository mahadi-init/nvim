_G.QuranAudio = {
  audio_path = vim.fn.expand("~/.config/nvim/lua/quran/audio/"),
  player_cmd = "mpv",
  player_args = { "--no-terminal", "--audio-display=no" }
}

local surah_list = {
  "Al-Fatihah (1)", "Al-Baqarah (2)", "Aal-E-Imran (3)", "An-Nisa (4)", "Al-Ma'idah (5)",
  "Al-An'am (6)", "Al-A'raf (7)", "Al-Anfal (8)", "At-Tawbah (9)", "Yunus (10)",
  "Hud (11)", "Yusuf (12)", "Ar-Ra'd (13)", "Ibrahim (14)", "Al-Hijr (15)",
  "An-Nahl (16)", "Al-Isra (17)", "Al-Kahf (18)", "Maryam (19)", "Ta-Ha (20)",
  "Al-Anbiya (21)", "Al-Hajj (22)", "Al-Mu'minun (23)", "An-Nur (24)", "Al-Furqan (25)",
  "Ash-Shu'ara (26)", "An-Naml (27)", "Al-Qasas (28)", "Al-Ankabut (29)", "Ar-Rum (30)",
  "Luqman (31)", "As-Sajdah (32)", "Al-Ahzab (33)", "Saba (34)", "Fatir (35)",
  "Ya-Sin (36)", "As-Saffat (37)", "Sad (38)", "Az-Zumar (39)", "Ghafir (40)",
  "Fussilat (41)", "Ash-Shura (42)", "Az-Zukhruf (43)", "Ad-Dukhan (44)", "Al-Jathiyah (45)",
  "Al-Ahqaf (46)", "Muhammad (47)", "Al-Fath (48)", "Al-Hujurat (49)", "Qaf (50)",
  "Adh-Dhariyat (51)", "At-Tur (52)", "An-Najm (53)", "Al-Qamar (54)", "Ar-Rahman (55)",
  "Al-Waqi'ah (56)", "Al-Hadid (57)", "Al-Mujadila (58)", "Al-Hashr (59)", "Al-Mumtahanah (60)",
  "As-Saff (61)", "Al-Jumu'ah (62)", "Al-Munafiqun (63)", "At-Taghabun (64)", "At-Talaq (65)",
  "At-Tahrim (66)", "Al-Mulk (67)", "Al-Qalam (68)", "Al-Haqqah (69)", "Al-Ma'arij (70)",
  "Nuh (71)", "Al-Jinn (72)", "Al-Muzzammil (73)", "Al-Muddathir (74)", "Al-Qiyamah (75)",
  "Al-Insan (76)", "Al-Mursalat (77)", "An-Naba (78)", "An-Nazi'at (79)", "Abasa (80)",
  "At-Takwir (81)", "Al-Infitar (82)", "Al-Mutaffifin (83)", "Al-Inshiqaq (84)", "Al-Buruj (85)",
  "At-Tariq (86)", "Al-A'la (87)", "Al-Ghashiyah (88)", "Al-Fajr (89)", "Al-Balad (90)",
  "Ash-Shams (91)", "Al-Lail (92)", "Ad-Duha (93)", "Ash-Sharh (94)", "At-Tin (95)",
  "Al-Alaq (96)", "Al-Qadr (97)", "Al-Bayyinah (98)", "Az-Zalzalah (99)", "Al-Adiyat (100)",
  "Al-Qari'ah (101)", "At-Takathur (102)", "Al-Asr (103)", "Al-Humazah (104)", "Al-Fil (105)",
  "Quraysh (106)", "Al-Ma'un (107)", "Al-Kawthar (108)", "Al-Kafirun (109)", "An-Nasr (110)",
  "Al-Masad (111)", "Al-Ikhlas (112)", "Al-Falaq (113)", "An-Nas (114)"
}

local function play_surah(surah_num)
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

  vim.fn.jobstart(args, { detach = true })
  return true
end

-- Clean UI for selecting and playing Surahs
vim.api.nvim_create_user_command("QuranSurah", function()
  vim.ui.select(surah_list, {
    prompt = "Select Surah to Play:",
    format_item = function(item)
      return item
    end,
  }, function(choice)
    if not choice then return end

    -- Extract the number from "Surah Name (XX)"
    local surah_num = tonumber(choice:match("(%d+)"))
    if surah_num and play_surah(surah_num) then
      print("▶️ Playing: " .. choice)
    end
  end)
end, {})

print("Quran audio player loaded: :QuranSurah")
