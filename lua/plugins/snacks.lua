return {
  'folke/snacks.nvim',
  event = 'VeryLazy',
  opts = {
    bufDelete = {},
    lazygit = {},
    notifier = {},
    quickfile = {},
    indent = {},
    statuscolumn = {},
    scope = {},
    picker = {},
  },
  config = function(_, opts)
    local map = vim.keymap.set

    require('snacks').setup(opts)

    -- Keymaps
    map('n', '<leader>fd', function()
      require('snacks').picker.diagnostics()
    end, { desc = 'Find diagnostics/errors' })
    map('v', '<C-f>', function()
      require('snacks').picker.grep_word()
    end, { desc = 'Find word under selection' })
    map('n', '<C-x>', function()
      require('snacks').bufdelete()
    end, { desc = 'Delete buffer' })
  end,
}
