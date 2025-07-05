return {
  "stevearc/oil.nvim",
  event = "VeryLazy",
  config = function()
    local oil = require("oil")
    local fzf = require("fzf-lua")

    oil.setup({
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
      local cwd = vim.fn.getcwd()
      local fd_cmd = "fd --type d --hidden --exclude .git"

      -- Run the `fd` command to get folder list
      local fd_handle = io.popen(fd_cmd)
      local results = {}
      if fd_handle then
        for line in fd_handle:lines() do
          table.insert(results, line)
        end
        fd_handle:close()
      end

      -- Prepend the current directory
      table.insert(results, 1, ".") -- relative path or use cwd for absolute

      -- Show folders using fzf-lua
      require("fzf-lua").fzf_exec(results, {
        prompt = "Select folder » ",
        cwd = cwd,
        file_icons = false,
        color_icons = false,
        git_icons = false,
        previewer = false,
        actions = {
          ["default"] = function(selected)
            if selected and selected[1] then
              local clean_path = selected[1]:match("^%s*(.-)%s*$")
              -- Use absolute path
              clean_path = vim.fn.fnamemodify(clean_path, ":p")
              require("oil").open(clean_path)
            end
          end,
        },
      })
    end, { desc = "Search & Open Folder in Oil (fzf-lua)" })

    Key("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
  end
}
