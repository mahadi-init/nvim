return {
  'heilgar/bookmarks.nvim',
  dependencies = {
    'kkharji/sqlite.lua',
  },
  config = function()
    require('bookmarks').setup {
      default_mappings = true,
      db_path = vim.fn.stdpath 'data' .. '/bookmarks.db',
    }
    require('telescope').load_extension 'bookmarks'
  end,
  cmd = {
    'BookmarkAdd',
    'BookmarkRemove',
    'Bookmarks',
  },
  keys = {
    { '<leader>ba', '<cmd>BookmarkAdd<cr>',    desc = 'Add Bookmark' },
    { '<leader>br', '<cmd>BookmarkRemove<cr>', desc = 'Remove Bookmark' },
    { '<leader>bl', '<cmd>Bookmarks<cr>',      desc = 'List Bookmarks' },
  },
}
