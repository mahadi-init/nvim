local worktime = require 'worktime'
local start_time = os.time()

-- Autocmd for UIEnter and ColorScheme
vim.api.nvim_create_autocmd({ 'UIEnter', 'ColorScheme' }, {
  callback = function()
    local normal = vim.api.nvim_get_hl(0, { name = 'Normal' })
    if not normal.bg then
      return
    end
    io.write(string.format('\027]11;#%06x\027\\', normal.bg))
  end,
})

-- Autocmd for UILeave
vim.api.nvim_create_autocmd('UILeave', {
  callback = function()
    io.write '\027]111\027\\'
  end,
})

-- highlight yanks
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank { higroup = 'IncSearch', timeout = 200 }
  end,
})

-- timer and session
vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    worktime.start_timer()
    worktime.start_session()
  end,
})

-- timer and session
vim.api.nvim_create_autocmd('VimLeavePre', {
  callback = function()
    local end_time = os.time()
    worktime.add_session(start_time, end_time)
  end,
})

-- Auto-organize imports on save
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*.py',
  callback = function()
    vim.lsp.buf.code_action {
      context = { only = { 'source.organizeImports' } },
      apply = true,
    }
  end,
})
