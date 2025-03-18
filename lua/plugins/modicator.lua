return {
  'mawkler/modicator.nvim',
  dependencies = 'catppuccin/nvim',
  event = 'VeryLazy',
  init = function()
    vim.o.number = true
    vim.o.cursorline = true
    vim.o.termguicolors = true
  end,
}
