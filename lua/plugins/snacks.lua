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
    explorer = {},
  },
  config = function(_, opts)
    require('snacks').setup(opts)

    -- Keymaps
    Key('n', '<leader>fd', function()
      require('snacks').picker.diagnostics()
    end, { desc = 'Find diagnostics/errors' })

    Key('v', '<C-f>', function()
      require('snacks').picker.grep_word()
    end, { desc = 'Find word under selection' })

    Key('n', '<C-x>', function()
      require('snacks').bufdelete()
    end, { desc = 'Delete buffer' })

    Key('n', '<leader>e', function()
      Snacks.explorer.open(opts)
    end, { desc = 'Delete buffer' })
  end,
}
