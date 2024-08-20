return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  ---@module "ibl"
  opts = {},
  config = function()
    require("ibl").setup({
      scope = { enabled = false },
    })
  end
}
