return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = function()
    require('toggleterm').setup {
      direction = 'float',
      open_mapping = [[<c-k>]],
      start_in_insert = true,
      persist_size = true,
      close_on_exit = true,
      shell = vim.o.shell,
      hide_numbers = true,
      float_opts = {
        border = 'curved',
        winblend = 0,
        title_pos = 'center',
      },
    }
  end,
}
