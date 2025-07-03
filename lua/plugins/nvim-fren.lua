return {
  "lambdalisue/vim-fern",
  event = "VeryLazy",
  dependencies = {
  },
  config = function()
    Key("n", "<leader>e", "<CMD>:Fern . -drawer -toggle<CR>")
    Key("n", "-", "<CMD>:Fern . -reveal=%<CR>")
  end
}
