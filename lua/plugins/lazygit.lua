return {
  'kdheepak/lazygit.nvim',
  event = 'VeryLazy',
  cmd = {
    'LazyGit',
    'LazyGitConfig',
    'LazyGitCurrentFile',
    'LazyGitFilter',
    'LazyGitFilterCurrentFile',
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    Key('n', '<leader>gg', '<CMD>LazyGit<CR>', { desc = 'LazyGit' }) -- file tree
  end,
}
