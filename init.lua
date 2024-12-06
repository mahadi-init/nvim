--> REMOVE PADDING STARTS
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
--> REMOVE PADDING ENDS

--> OPTIONS
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

-- Hide mode indicator
opt.showmode = true

-- Enable relative line numbers
opt.relativenumber = true

-- Disable line wrapping
opt.wrap = false

--> OPTIONS END

--> LAZY NVIM PACKAGE MANAGER STARTS
-- Set up lazy.nvim path and repository
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
local lazyrepo = 'https://github.com/folke/lazy.nvim.git'

-- Clone lazy.nvim if not already present
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local out = vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    lazyrepo,
    '--branch=stable',
    lazypath,
  }
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out, 'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

-- Prepend lazy.nvim to runtime path
vim.opt.rtp:prepend(lazypath)

-- Set leader keys
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

-- Lazy.nvim setup
require('lazy').setup {
  spec = {
    { import = 'plugins' },
  },
  install = { colorscheme = { 'gruvbox' } },
  checker = { enabled = true },
}
--> LAZY NVIM ENDS

--> KEYMAPS STARTS HERE
vim.keymap.set({'n', 'i'}, '<C-s>', ':w<CR>') -- save file
vim.keymap.set('n', '<leader>q', ':q<CR>') -- quit neovim

-- fzf
vim.keymap.set('n', '<leader><leader>', require("fzf-lua").files, {desc="find files"}) -- find files
vim.keymap.set('n', '<leader>fw', require("fzf-lua").live_grep, {desc="find words"}) -- live grep
vim.keymap.set('n', '<leader>fb', require("fzf-lua").buffers, {desc="find buffer"}) -- find buffers
vim.keymap.set('n', '<leader>fq', require("fzf-lua").quickfix, {desc="quickfix locallist"}) -- quickfix
vim.keymap.set('n', '<leader>fg', require("fzf-lua").git_files, {desc="git files"}) -- git files
vim.keymap.set('n', '<leader>fs', require("fzf-lua").git_status, {desc="git status"}) -- git status

--fern file tree
vim.keymap.set('n', '<leader>e', ":Fern . -reveal=% -drawer -toggle<CR>", {desc="file tree"}) -- file tree
--> KEYMAPS ENDS HERE
