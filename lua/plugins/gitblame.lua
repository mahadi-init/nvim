return {
  'f-person/git-blame.nvim',
  event = 'VeryLazy',
  -- enabled = false,
  config = function()
    require('gitblame').setup {
      enabled = true,
      message_template = ' <summary> • <author> •  <date> ',
      date_format = '%I:%M %p %a, %d %b %Y',
      virtual_text_column = 1,
    }
  end,
}
