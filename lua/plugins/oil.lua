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
      vim.fn.inputsave()
      local path = vim.fn.input("Oil: Open Path » ", vim.fn.getcwd() .. "/", "file")
      vim.fn.inputrestore()
      if path ~= "" then vim.cmd.Oil(path) end
    end, { desc = "Open Oil file explorer" })

    Key("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
  end
}
