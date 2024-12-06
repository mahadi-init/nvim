vim.keymap.set({ 'n', 'i' }, '<C-s>', ':w<CR>') -- save file
vim.keymap.set('n', '<leader>q', ':q<CR>') -- quit neovim
vim.keymap.set('n', '<ESC>', ':nohlsearch<CR>') -- escape and remove search query
vim.keymap.set('n', '<C-x>', ':Bdelete<CR>') -- remove buffer
vim.keymap.set('n', '<C-j>', '<C-d>zz') -- scroll down
vim.keymap.set('n', '<C-k>', '<C-u>zz') -- scroll up
vim.keymap.set('n', '<C-v>', ':vsplit<CR>') -- vertical split
vim.keymap.set('n', '<C-Right>', ':bnext<CR>') -- next buffer
vim.keymap.set('n', '<C-Left>', ':bprevious<CR>') -- previous buffer

-- fzf
vim.keymap.set('n', '<leader><leader>', require('fzf-lua').files, { desc = 'find files' }) -- find files
vim.keymap.set('n', '<leader>fw', require('fzf-lua').live_grep, { desc = 'find words' }) -- live grep
vim.keymap.set('n', '<leader>fb', require('fzf-lua').buffers, { desc = 'find buffer' }) -- find buffers
vim.keymap.set('n', '<leader>fq', require('fzf-lua').quickfix, { desc = 'quickfix locallist' }) -- quickfix
vim.keymap.set('n', '<leader>fg', require('fzf-lua').git_files, { desc = 'git files' }) -- git files
vim.keymap.set('n', '<leader>fs', require('fzf-lua').git_status, { desc = 'git status' }) -- git status

-- fern file tree
vim.keymap.set('n', '<leader>e', ':Neotree filesystem toggle<CR>', { desc = 'neo tree open' }) -- file tree

-- session
vim.keymap.set('n', '<leader>ls', function()
  require('persistence').load()
end)

-- lazygit
vim.keymap.set('n', '<leader>gg', ':LazyGit<CR>', { desc = 'LazyGit' }) -- file tree
