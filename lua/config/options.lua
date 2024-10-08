local opt = vim.opt

opt.termguicolors = true
opt.laststatus = 0
opt.clipboard = 'unnamedplus'
opt.expandtab = true
opt.shiftwidth = 2
opt.shiftround = true
opt.showmode = false
opt.smartindent = true
opt.relativenumber = true
opt.wrap = false
opt.cmdheight = 0

-- diagnostic sidebar hide
vim.diagnostic.config {
  signs = false,
}
