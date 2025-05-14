local opt = vim.opt

-- Detect if nerd font is available
vim.g.have_nerd_font = false -- Set to true if you have a nerd font installed
vim.g.is_mac = (vim.loop.os_uname().sysname == "Darwin")

-- Enable true color support
opt.termguicolors = true

-- Use system clipboard
opt.clipboard = vim.g.is_mac and 'unnamedplus' or 'unnamed,unnamedplus'

-- Performance settings
opt.lazyredraw = true      -- Don't redraw while executing macros
opt.updatetime = 100       -- Faster completion and better UX

-- Use spaces instead of tabs and set indentation
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftround = true
opt.smartindent = true
opt.ignorecase = true
opt.smartcase = true       -- Case-sensitive when using uppercase
opt.laststatus = 3         -- Global statusline
opt.splitbelow = true      -- Open new split below
opt.splitright = true      -- Open new split to the right

-- Hide mode indicator since we have a statusline
opt.showmode = false

-- Enable relative line numbers
opt.relativenumber = true
opt.number = true
opt.scrolloff = 8          -- Keep 8 lines above/below cursor when scrolling
opt.cursorline = true      -- Highlight current line

-- Disable line wrapping
opt.wrap = false

-- Search settings
opt.hlsearch = true        -- Highlight search results
opt.incsearch = true       -- Incremental search

-- Diagnostics display
vim.diagnostic.config {
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
}

-- Folding with ufo
vim.o.foldcolumn = '1'     -- '0' is not bad
vim.o.foldlevel = 99       -- Using ufo provider need a large value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- Completion settings
opt.completeopt = 'menu,menuone,noselect'
