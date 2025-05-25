return {
  'b0o/incline.nvim',
  event = 'VeryLazy',
  config = function()
    local helpers = require 'incline.helpers'
    local devicons = require 'nvim-web-devicons'

    require('incline').setup {
      window = {
        padding = 0,
        margin = { horizontal = 0 },
      },
      render = function(props)
        local full_path = vim.api.nvim_buf_get_name(props.buf)
        local filename = vim.fn.fnamemodify(full_path, ':t')
        if filename == '' then
          filename = '[No Name]'
        end

        -- Extract last 3 directory levels
        local dir_path = vim.fn.fnamemodify(full_path, ':h')
        local dir_parts = {}
        for part in string.gmatch(dir_path, '([^/]+)') do
          table.insert(dir_parts, part)
        end

        local display_path = ''
        if #dir_parts > 0 then
          -- Take last 3 parts and join with /
          local start_idx = math.max(1, #dir_parts - 2)
          display_path = table.concat({ unpack(dir_parts, start_idx) }, '/') .. '/'
        end

        local ft_icon, ft_color = devicons.get_icon_color(filename)
        local modified = vim.bo[props.buf].modified

        return {
          ft_icon and { ' ', ft_icon, ' ', guibg = ft_color, guifg = helpers.contrast_color(ft_color) } or '',
          ' ',
          { display_path, guifg = '#a89984' }, -- Path in muted color
          { filename, gui = modified and 'bold,italic' or 'bold' },
          ' ',
          guibg = '#44406e',
        }
      end,
    }
  end,
}
