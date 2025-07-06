return {
  dir = vim.fn.stdpath 'config' .. '/lua/outline',
  name = 'outline',
  event = 'VeryLazy',
  config = function()
    require('outline').setup {
      width = 40,
      position = 'right',
      auto_open = false,
      auto_close = true,
    }

    Key('n', '<C-h>', '<CMD>HtmlCommentOutline<CR>')
  end,
}
