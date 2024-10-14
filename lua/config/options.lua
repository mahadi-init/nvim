local opt = vim.opt

-- Enable true color support
opt.termguicolors = true

-- Always display the status line
opt.laststatus = 0

-- Use system clipboard
opt.clipboard = 'unnamedplus'

-- Use spaces instead of tabs and set indentation
opt.expandtab = true
opt.shiftwidth = 2
opt.shiftround = true
opt.smartindent = true

-- Hide mode indicator
opt.showmode = false

-- Enable relative line numbers
opt.relativenumber = true

-- Disable line wrapping
opt.wrap = false

-- Set command line height
opt.cmdheight = 0

-- Disable diagnostic signs in the sidebar
vim.diagnostic.config {
  signs = false,
}
