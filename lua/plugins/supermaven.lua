return {
  "supermaven-inc/supermaven-nvim",
  config = function()
    require("supermaven-nvim").setup({
      keymaps = {
        accept_suggestion = "<Tab>",
        clear_suggestion = "<M-]>",
      },
      ignore_filetypes = { ["neo-tree"] = true, ["DressingInput"] = true, ["neo-tree-popup"] = true },
    })
  end,
}
