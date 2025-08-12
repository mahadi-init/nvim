return {
  'echasnovski/mini.nvim',
  version = false,
  config = function()
    require('mini.starter').setup()
    require('mini.icons').setup()
    require('mini.statusline').setup()
    require('mini.tabline').setup()
    require('mini.pairs').setup()
    require('mini.git').setup()

    require('mini.diff').setup {
      view = {
        style = 'sign',
        signs = { add = '┃', change = '┃', delete = '┃' },
        priority = 199,
      },
    }

    local hipatterns = require 'mini.hipatterns'
    hipatterns.setup {
      highlighters = {
        fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
        hack = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
        todo = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
        note = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },
        hex_color = hipatterns.gen_highlighter.hex_color(),
      },
    }
  end,
}
