return {
  'nvim-orgmode/orgmode',
  event = 'VeryLazy',
  ft = { 'org' },
  dependencies = {
    {
      'nvim-orgmode/telescope-orgmode.nvim',
      event = 'VeryLazy',
    },
  },
  config = function()
    require('telescope').load_extension 'orgmode'
    require('orgmode').setup {
      org_agenda_files = '~/orgfiles/**/*',
      org_default_notes_file = '~/orgfiles/refile.org',
    }

    -- keymaps
    vim.keymap.set('n', '<leader>fr', require('telescope').extensions.orgmode.search_headings) -- org mode telescope
  end,
}
