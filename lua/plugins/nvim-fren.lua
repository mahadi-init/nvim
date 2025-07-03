return {
  "lambdalisue/vim-fern",
  event = "VeryLazy",
  dependencies = {
  },
  config = function()
    Key("n", "<leader>e", "<CMD>:Fern . -reveal=% -drawer -toggle<CR>")
    Key("n", "-", "<CMD>:Fern . -reveal=%<CR>")
  end
}
