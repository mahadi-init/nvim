return {
  "stevearc/oil.nvim",
  event = "VeryLazy",
  config = function()
    require("oil").setup()
    Key("n", "<leader>e", function()
      vim.ui.input({
        prompt = "Open Oil at path: ",
        default = vim.fn.getcwd() .. "/",
        completion = "file",
        -- Use fzf-lua as the UI selector
        ui = pcall(require, 'fzf-lua') and require('fzf-lua').input or nil
      }, function(path)
        if path and path ~= "" then
          vim.cmd.Oil(path)
        end
      end)
    end, { desc = "Open Oil file explorer with fzf suggestions" })

    Key("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
  end
}
