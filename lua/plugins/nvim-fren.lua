return {
  "lambdalisue/vim-fern",
  event = "VeryLazy",
  dependencies = {
    "TheLeoP/fern-renderer-web-devicons.nvim",
  },
  config = function()
    vim.g["fern#renderer"] = "nvim-web-devicons"

    Key("n", "<leader>e", "<CMD>:Fern . -drawer -toggle<CR>")
    Key("n", "-", "<CMD>:Fern . -reveal=%<CR>")
  end
}
