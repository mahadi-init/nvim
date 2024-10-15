return {
  'nvim-telescope/telescope-frecency.nvim',
  requires = { 'tami5/sqlite.lua' }, -- Ensure this dependency is included
  config = function()
    require('telescope').load_extension 'frecency'
    require('telescope').setup {
      extensions = {
        frecency = {
          show_scores = false,
          show_unindexed = true,
          ignore_patterns = { '*.git/*', '*/tmp/*', 'node_modules', '.next' },
          workspaces = {
            ['conf'] = '/home/user/.config',
            ['data'] = '/home/user/.local/share',
            ['project'] = '/home/user/projects',
            ['wiki'] = '/home/user/wiki',
          },
        },
      },
      defaults = {
        path_display = function(opts, path)
          local tail = require('telescope.utils').path_tail(path)
          return string.format('%s', tail)
        end,
      },
    }
  end,
}
