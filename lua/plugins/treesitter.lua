return {
  'nvim-treesitter/nvim-treesitter',
  event = 'VeryLazy',
  config = function()
    require('nvim-treesitter.configs').setup {
      ensure_installed = {
        'lua', 'vim', 'vimdoc', 'tsx', 'typescript', 'javascript',
        'html', 'css', 'json', 'prisma', 'markdown', 'markdown_inline'
      },
      highlight = { enable = true },
      indent = { enable = true },
      autotag = { enable = true },
      incremental_selection = { enable = true },
      additional_vim_regex_highlighting = false,
    }
  end,
}
