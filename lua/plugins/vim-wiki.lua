return {
  'vimwiki/vimwiki',
  lazy = true,
  event = 'VeryLazy',
  config = function()
    vim.cmd 'filetype plugin indent on'
    vim.cmd 'syntax enable'
    vim.g.vimwiki_list = {
      path = '~/vimwiki/',
      syntax = 'markdown',
      ext = 'md',
    }
    vim.g.vimwiki_global_ext = 0
  end,
}
