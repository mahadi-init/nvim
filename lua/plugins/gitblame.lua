return {
  'f-person/git-blame.nvim',
  config = function()
    require('gitblame').setup {
      enabled = true,
      date_format = '%I:%M %p %a, %d %b %Y',
    }
  end,
}
