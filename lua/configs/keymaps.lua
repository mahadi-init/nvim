vim.keymap.set({ 'n', 'i' }, '<C-s>', ':w<CR>') -- save file
vim.keymap.set('n', '<leader>q', ':q<CR>') -- quit neovim
vim.keymap.set('n', '<ESC>', ':nohlsearch<CR>') -- escape and remove search query
vim.keymap.set('n', '<C-j>', '<C-d>zz') -- scroll down
vim.keymap.set('n', '<C-k>', '<C-u>zz') -- scroll up
vim.keymap.set('n', '<C-v>', ':vsplit<CR>') -- vertical split
vim.keymap.set('n', '<C-Right>', ':bnext<CR>') -- next buffer
vim.keymap.set('n', '<C-Left>', ':bprevious<CR>') -- previous buffer

-- telescope
local telescope = require 'telescope.builtin'
vim.keymap.set('n', '<leader><leader>', telescope.find_files, { desc = 'find files' }) -- find files
vim.keymap.set('n', '<leader>f', telescope.live_grep, { desc = 'find words' }) -- live grep
vim.keymap.set('n', '<leader>b', telescope.buffers, { desc = 'find buffer' }) -- find buffers
vim.keymap.set('n', '<leader>fq', telescope.quickfix, { desc = 'quickfix locallist' }) -- quickfix
vim.keymap.set('n', '<leader>fg', telescope.git_files, { desc = 'git files' }) -- git files
vim.keymap.set('n', '<leader>fs', telescope.git_status, { desc = 'git status' }) -- git status

-- file tree
vim.keymap.set('n', '<leader>e', ':Neotree filesystem toggle<CR>', { desc = 'neo tree open' }) -- file tree

-- session
vim.keymap.set('n', '<leader>ls', function()
  require('persistence').load()
end)

-- lazygit
vim.keymap.set('n', '<leader>gg', ':LazyGit<CR>', { desc = 'LazyGit' }) -- file tree

-- buf delete
vim.keymap.set('n', '<C-x>', ':lua Snacks.bufdelete()<CR>', { desc = 'Delete buffer' })

-- show current line blame
vim.api.nvim_set_keymap('n', '<leader>gb', ':lua Snacks.git.blame_line()<CR>', { noremap = true, silent = true })

-- spectre
vim.keymap.set('n', '<C-t>', '<cmd>lua require("spectre").toggle()<CR>', {
  desc = 'Toggle Spectre',
})
-- vim.keymap.set({ 'n', 'v' }, '<C-F>', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
--   desc = 'Search current word',
-- })
vim.keymap.set({ 'n', 'v' }, '<C-f>', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
  desc = 'Search on current file',
})
