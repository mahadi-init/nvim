return {
  'romgrk/barbar.nvim',
  version = '^1.0.0',
  event = 'BufWinEnter',
  opts = function()
    math.randomseed(os.time()) -- <--- Add this line here
    local slogans = {
      'Code is Poetry',
      'Eat Sleep Code Repeat',
      'Debugging is twice as hard',
      'Keep Calm and Code On',
      'Programmers hate semicolons',
      'Hello World!',
      'It works on my machine',
      "Git commit -m 'Fix stuff'",
      'No bugs, just features',
      'Infinite loops are fun',
      'I came here to chew bubblegum...',
      'Ctrl+C, Ctrl+V',
      'YAGNI, KISS, SOLID',
      'Write code that writes code',
      'Lesser dependencies, fewer problems',
      'If it compiles, ship it!',
      'Always be refactoring',
      'Talk is cheap. Show me the code.',
      'Optimize for happiness',
      'Readability counts.',
    }

    local slogan = slogans[math.random(#slogans)]

    return {
      animation = true,
      insert_at_end = true,
      no_name_title = slogan,
    }
  end,
  init = function()
    vim.g.barbar_auto_setup = false

    -- buffer switch
    Key('n', '<C-Left>', '<Cmd>BufferPrevious<CR>')
    Key('n', '<C-Right>', '<Cmd>BufferNext<CR>')
  end,
}
