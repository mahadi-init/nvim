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
    input = {},
  },
  keys = {
    -- Find Files
    {
      '<leader><leader>',
      function()
        Snacks.picker.smart()
      end,
      desc = 'Smart Find Files',
    },

    -- Buffers
    {
      '<C-b>',
      function()
        Snacks.picker.buffers()
      end,
      desc = 'Buffers',
    },

    -- Grep
    {
      '<C-/>',
      function()
        Snacks.picker.grep()
      end,
      desc = 'Grep',
    },

    -- Find Projects
    {
      '<leader>fp',
      function()
        Snacks.picker.projects()
      end,
      desc = 'Projects',
    },

    -- Find inside buffers
    {
      '<leader>fb',
      function()
        Snacks.picker.grep_buffers()
      end,
      desc = 'Grep Open Buffers',
    },

    -- Git Branches
    {
      '<leader>gb',
      function()
        Snacks.picker.git_branches()
      end,
      desc = 'Git Branches',
    },

    -- Grep Words
    {
      '<C-f>',
      function()
        Snacks.picker.grep_word()
      end,
      desc = 'Visual selection or word',
      mode = { 'x' },
    },

    -- Diagnostics
    {
      '<leader>fd',
      function()
        Snacks.picker.diagnostics()
      end,
      desc = 'Diagnostics',
    },

    -- git status
    {
      '<C-g>',
      function()
        Snacks.picker.git_status()
      end,
      desc = 'Git Status',
    },

    -- Git Diff
    {
      '<leader>gd',
      function()
        Snacks.picker.git_diff()
      end,
      desc = 'Git Diff (Hunks)',
    },

    -- Sb Lines
    {
      '<leader>sb',
      function()
        Snacks.picker.lines()
      end,
      desc = 'Buffer Lines',
    },

    -- Find Icons
    {
      '<leader>si',
      function()
        Snacks.picker.icons()
      end,
      desc = 'Icons',
    },

    -- Find keymaps
    {
      '<leader>sk',
      function()
        Snacks.picker.keymaps()
      end,
      desc = 'Keymaps',
    },

    -- Find Marks
    {
      '<leader>sm',
      function()
        Snacks.picker.marks()
      end,
      desc = 'Marks',
    },

    -- Delete Buffer
    {
      '<C-x>',
      function()
        Snacks.bufdelete()
      end,
      desc = 'Delete Buffer',
    },
  },
}
