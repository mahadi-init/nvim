return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  event = 'VeryLazy',
  enabled = true,
  config = function()
    require('lualine').setup {
      options = {
        icons_enabled = true,
        theme = 'gruvbox-material',
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
          function()
            local ok, pomo = pcall(require, 'pomo')
            if not ok then
              return ''
            end

            local timer = pomo.get_first_to_finish()
            if timer == nil then
              return ''
            end

            return '󰄉 ' .. tostring(timer)
          end,
        },
        lualine_x = {
          function()
            if require('lazydo')._initialized then
              return require('lazydo').get_lualine_stats()
            end
          end,
        },
        lualine_y = { 'diff', 'filetype' },
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
