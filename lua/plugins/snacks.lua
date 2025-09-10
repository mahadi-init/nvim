return {
  'folke/snacks.nvim',
  lazy = false,
  opts = {
    bufDelete = {},
    quickfile = {},
    indent = {},
    statuscolumn = {},
    scope = {},
    picker = {},
    input = {},
    dashboard = {},
    notifier = {},
  },
  keys = {
    {
      '<leader><leader>',
      function()
        Snacks.picker.files()
      end,
      desc = 'Buffers',
    },
    {
      '<C-l>',
      function()
        Snacks.picker.buffers()
      end,
      desc = 'Buffers',
    },
    {
      '<C-/>',
      function()
        Snacks.picker.grep()
      end,
      desc = 'Grep',
    },
    {
      '<C-f>',
      function()
        Snacks.picker.grep_word()
      end,
      desc = 'Visual selection or word',
      mode = { 'x' },
    },
    {
      '<C-g>',
      function()
        Snacks.picker.git_status()
      end,
      desc = 'Git Status',
    },
    {
      '<C-x>',
      function()
        Snacks.bufdelete()
      end,
      desc = 'Delete Buffer',
    },
  },
}
