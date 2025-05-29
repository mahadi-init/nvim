-- Optimized Neovim options
local opt = vim.opt
local g = vim.g

-- Performance options
opt.lazyredraw = true -- Don't redraw screen during macros
opt.synmaxcol = 240 -- Avoid syntax highlighting for extremely long lines

-- UI Appearance
opt.termguicolors = true -- Enable true color support
opt.showmode = false -- Hide mode indicator (shown in statusline)
opt.relativenumber = true -- Relative line numbers
opt.number = true -- Show current line number
opt.signcolumn = 'yes' -- Always show sign column
opt.laststatus = 2 -- Always show statusline
opt.wrap = false -- Disable line wrapping
opt.fillchars = { eob = ' ' } -- Remove ~ at end of buffer
opt.scrolloff = 5 -- Keep 5 lines visible when scrolling
opt.splitbelow = true -- Open horizontal splits below
opt.splitright = true -- Open vertical splits to the right
opt.cursorline = true -- Highlight current line

-- Editing behavior
opt.expandtab = true -- Use spaces instead of tabs
opt.shiftwidth = 2 -- 2 spaces for indentation
opt.tabstop = 2 -- 2 spaces per tab
opt.softtabstop = 2 -- 2 spaces per tab in insert mode
opt.smartindent = true -- Auto-indent new lines
opt.shiftround = true -- Round indentation to shiftwidth
opt.timeoutlen = 300 -- Faster key sequence completion
opt.updatetime = 250 -- Faster completion
opt.clipboard = 'unnamedplus' -- Use system clipboard

-- Search behavior
opt.ignorecase = true -- Case-insensitive search
opt.smartcase = true -- Case-sensitive if uppercase present
opt.hlsearch = true -- Highlight search results
opt.incsearch = true -- Incremental search

-- File behavior
opt.undofile = true -- Persistent undo history
opt.swapfile = false -- No swap files
opt.backup = false -- No backup files
opt.writebackup = false -- No backup before writing
opt.autoread = true -- Auto-reload changed files

-- Folding (for ufo plugin)
opt.foldcolumn = '1' -- Show fold indicators
opt.foldlevel = 99 -- High fold level by default
opt.foldlevelstart = 99 -- Start with all folds open
opt.foldenable = true -- Enable folding

-- Diagnostics appearance
vim.diagnostic.config {
  virtual_text = false, -- No virtual text
  signs = true, -- Show signs
  underline = true, -- Underline text
  update_in_insert = false, -- Only update diagnostics after leaving insert mode
  severity_sort = true, -- Sort by severity
  float = {
    border = 'rounded',
    source = 'always',
  },
}

-- Completion options
opt.completeopt = { 'menu', 'menuone', 'noselect' }

-- Disable built-in plugins to reduce startup time
local disabled_built_ins = {
  '2html_plugin',
  'getscript',
  'getscriptPlugin',
  'gzip',
  'logipat',
  'netrw',
  'netrwPlugin',
  'netrwSettings',
  'netrwFileHandlers',
  'matchit',
  'tar',
  'tarPlugin',
  'rrhelper',
  'spellfile_plugin',
  'vimball',
  'vimballPlugin',
  'zip',
  'zipPlugin',
}

for _, plugin in pairs(disabled_built_ins) do
  g['loaded_' .. plugin] = 1
end

-- FIXME: REMOVE SOME TIME
vim.deprecate = function(name, alternative, version, plugin, backtrace)
  -- Do nothing (silently ignore all deprecations)
end
