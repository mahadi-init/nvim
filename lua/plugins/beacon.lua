return {
  'danilamihailov/beacon.nvim',
  event = "VeryLazy",
  config = function()
    require('beacon').setup()
  end
}
