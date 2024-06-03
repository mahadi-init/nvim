return {
  "supermaven-inc/supermaven-nvim",
  event = "VeryLazy",
  config = function()
    require("supermaven-nvim").setup({
      keymaps = {
        accept_suggestion = "<C-Right>",
        clear_suggestion = "<C-]>",
        accept_word = "<C-Down>",
      },
      ignore_filetypes = {},
      color = {
        suggestion_color = "gray",
        cterm = 244,
      },
      -- disable_inline_completion = false, -- disables inline completion for use with cmp
      -- disable_keymaps = false, -- disables built in keymaps for more manual control
    })
  end,
}
