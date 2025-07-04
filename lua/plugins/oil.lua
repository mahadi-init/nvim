return {
  "stevearc/oil.nvim",
  event = "VeryLazy",
  config = function()
    require("oil").setup({
      default_file_explorer = true,
      skip_confirm_for_simple_edits = true,
      prompt_save_on_select_new_entry = false,
      cleanup_delay_ms = 2000,
      lsp_file_methods = {
        enabled = true,
        timeout_ms = 500,
        autosave_changes = true,
      },
      watch_for_changes = true,
      keymaps = {
        ["<CR>"] = "actions.select",
        ["<C-p>"] = "actions.preview",
        ["<C-l>"] = "actions.refresh",
        ["-"] = { "actions.parent", mode = "n" },
        ["_"] = { "actions.open_cwd", mode = "n" },
        ["g."] = { "actions.toggle_hidden", mode = "n" },
      },
      use_default_keymaps = false,
    })

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
