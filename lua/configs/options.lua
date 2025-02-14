local opt = vim.opt

-- Enable true color support
opt.termguicolors = true

-- Use system clipboard
opt.clipboard = 'unnamedplus'

-- Use spaces instead of tabs and set indentation
opt.expandtab = true
opt.shiftwidth = 2
opt.shiftround = true
opt.smartindent = true
opt.ignorecase = true
opt.laststatus = 2

-- Hide mode indicator
opt.showmode = false

-- Enable relative line numbers
opt.relativenumber = true
opt.number = true

-- Disable line wrapping
opt.wrap = false

vim.diagnostic.config {
  virtual_text = false,
  signs = true,
  underline = true,
}
