local worktime = require("worktime")

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
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank { higroup = "IncSearch", timeout = 200 }
  end,
})


vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    worktime.start_timer()
    worktime.start_session()
    vim.notify(worktime.print_total_time(), vim.log.levels.INFO)
  end
})

vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    worktime.stop_timer()
  end
})
