return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  config = function()
    local function quran_status()
      if _G.QuranAudio and _G.QuranAudio.current_surah then
        return string.format("🕌 %03d - %s", _G.QuranAudio.current_surah.number, _G.QuranAudio.current_surah.name)
      end
      return ""
    end

    require('lualine').setup {
      options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = true,
        refresh = {
          statusline = 10,
          tabline = 10,
          winbar = 10,
        },
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = {
          'branch',
          function()
            local path = vim.fn.expand('%:.') -- Get relative path
            local parts = {}

            -- Split path into components
            for part in string.gmatch(path, '([^/]+)') do
              table.insert(parts, part)
            end

            -- Return last 3 components joined with /
            if #parts > 3 then
              return table.concat({ parts[#parts - 2], parts[#parts - 1], parts[#parts] }, '/')
            end
            return path -- Return full path if <= 3 components
          end,
        },
        lualine_c = {
          'diagnostics',
        },
        lualine_x = {
          function()
            local progress = require('lsp-progress').progress()
            if progress:match 'LSP$' then
              return '󱚽 '
            end

            if progress ~= '' then
              return '󱛆 '
            end
            return ''
          end,
        },
        lualine_y = {
          function()
            return require("worktime").get_session_elapsed()
          end,
          quran_status,
          'filetype',
        },
        lualine_z = { 'location', 'progress' },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {},
    }
  end,
}
