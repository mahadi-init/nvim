return {
  "Exafunction/codeium.vim",
  event = "BufEnter",
  enabled = true,
  config = function()
    vim.keymap.set("i", "<C-Right>", function()
      return vim.fn["codeium#Accept"]()
    end, { expr = true, silent = true })
    vim.keymap.set("i", "<C-Left>", function()
      return vim.fn["codeium#Chat"]()
    end, { expr = true, silent = false })
  end,
}
