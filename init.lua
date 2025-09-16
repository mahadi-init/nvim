local vim = vim
local opt = vim.opt
Key = vim.keymap.set
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'
local Plug = vim.fn['plug#']

vim.call('plug#begin')

-- Color Schemes
Plug('dracula/vim', { ['as'] = 'dracula' })
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })  
Plug('junegunn/fzf', { ['do'] = vim.fn['fzf#install'] })  -- Fuzzy finder
Plug('junegunn/fzf.vim')  -- FZF integration

vim.call('plug#end')

-- Configure and load color scheme
vim.opt.background = 'dark'
vim.cmd('silent! colorscheme dracula')

-- Settings
opt.clipboard = 'unnamedplus' 
opt.termguicolors = true 
opt.winborder = 'rounded'
opt.relativenumber = true 
opt.number = true 
opt.wrap = false 
opt.fillchars = { eob = ' ' }
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2 
opt.softtabstop = 2 
opt.smartindent = true 
opt.shiftround = true 
opt.ignorecase = true 
opt.smartcase = true 
opt.hlsearch = false 
opt.incsearch = true 
opt.undofile = true 
opt.swapfile = false 
opt.backup = false 
opt.writebackup = false 
opt.autoread = true 

-- Keymps (Basic)
Key({ 'n', 'i', 'v' }, '<C-s>', '<CMD>w<CR>') 
Key('n', '<ESC>', '<CMD>nohlsearch<CR>') 
Key('n', '<C-v>', '<CMD>leftabove vsplit<CR>') 
Key('n', '<C-j>', '<C-d>') 
Key('n', '<C-k>', '<C-u>') 

-- QuickFix
Key('n', '<M-o>', '<CMD>copen<CR>', { desc = 'Open quickfix' })
Key('n', '<M-x>', '<CMD>cclose<CR>', { desc = 'close quickfix' })
Key('n', '<M-k>', '<CMD>cprev<CR>', { desc = 'previous quickfix' })
Key('n', '<M-j>', '<CMD>cnext<CR>', { desc = 'next quickfix' })

-- resize window
Key('n', '=', [[<cmd>vertical resize +5<cr>]]) 
Key('n', '-', [[<cmd>vertical resize -5<cr>]]) 

-- cycle between buffer
Key('n', '<C-l>', ':bnext<CR>', { desc = 'Next buffer' })
Key('n', '<C-h>', ':bprevious<CR>', { desc = 'Previous buffer' })

-- move lines
Key('n', '<M-Up>', ':m .-2<CR>==', { desc = 'Move line up' })
Key('v', '<M-Up>', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })
Key('n', '<M-Down>', ':m .+1<CR>==', { desc = 'Move line down' })
Key('v', '<M-Down>', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })

-- fzf
Key("n", "<leader><leader>", ":Files .<CR>", {desc = "find files"})
Key("n", "<C-b>", ":Buffers<CR>", {desc = "buffers"})
