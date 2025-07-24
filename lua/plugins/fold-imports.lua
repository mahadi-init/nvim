return {
  'dmtrKovalenko/fold-imports.nvim',
  opts = {},
  event = 'BufRead',
  config = function()
    require('fold_imports').setup {
      auto_fold = false,
    }

    Key('n', '<leader>fm', '<CMD>FoldImports<CR>')
  end,
}
