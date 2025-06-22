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
    require('snacks').setup(opts)

    -- Keymaps
    vim.keymap.set('n', '<leader>fd', function()
      require('snacks').picker.diagnostics()
    end, { desc = 'Find diagnostics/errors' })
    vim.keymap.set('v', '<C-f>', function()
      require('snacks').picker.grep_word()
    end, { desc = 'Find word under selection' })
    vim.keymap.set('n', '<C-x>', function()
      require('snacks').bufdelete()
    end, { desc = 'Delete buffer' })
  end,
}
