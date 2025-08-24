return {
  'folke/snacks.nvim',
  event = 'VeryLazy',
  opts = {
    bufDelete = {},
    -- notifier = {},
    quickfile = {},
    indent = {},
    statuscolumn = {},
    scope = {},
    picker = {},
    input = {},
    explorer = {},
  },
  keys = {
    {
      '<leader><leader>',
      function()
        Snacks.picker.files()
      end,
      desc = 'Smart Find Files',
    },
    {
      '<C-b>',
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
    {
      '<leader>e',
      function()
        Snacks.explorer()
      end,
      desc = 'Delete Buffer',
    },
  },
}
