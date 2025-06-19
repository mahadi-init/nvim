return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  config = function()
    local function custom_status()
      local status = require('codeium.virtual_text').status()

      if status.state == 'idle' then
        return ' '
      end

      if status.state == 'waiting' then
        return " "
      end

      if status.state == 'completions' and status.total > 0 then
        return string.format('%d/%d', status.current, status.total)
      end

      return ' 0 '
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
            local relative_filepath = vim.fn.expand '%:.'
            return relative_filepath
          end,
        },
        lualine_c = {
          'diagnostics',
        },
        lualine_x = {
          custom_status,
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
