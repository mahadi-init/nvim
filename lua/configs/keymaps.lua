local utils = require('configs.utils')
local map = utils.map
require('configs.import-format').setup()

-- General keymaps
local general_mappings = {
  { { 'n', 'i', 'v' }, '<C-s>', '<CMD>w<CR>', { desc = 'Save file' } },
  { 'n', '<leader>q', '<CMD>q<CR>', { desc = 'Quit neovim' } },
  { 'n', '<ESC>', '<CMD>nohlsearch<CR>', { desc = 'Clear search highlighting' } },
  { 'n', '<C-j>', '<C-d>zz', { desc = 'Scroll down' } },
  { 'n', '<C-k>', '<C-u>zz', { desc = 'Scroll up' } },
  { 'n', '<C-d>', '<C-d>zz', { desc = 'Scroll down' } },
  { 'n', '<C-u>', '<C-u>zz', { desc = 'Scroll up' } },
  { 'n', '<C-v>', '<CMD>vsplit<CR>', { desc = 'Vertical split' } },
  { 'n', '<C-Right>', '<CMD>BufferLineCycleNext<CR>', { desc = 'Next buffer' } },
  { 'n', '<C-Left>', '<CMD>BufferLineCyclePrev<CR>', { desc = 'Previous buffer' } },
  { 'n', 'zz', 'zzza', { remap = false, desc = 'Center screen and toggle fold' } },
  { 'n', 'zo', function() require('ufo').openAllFolds() end, { desc = 'Open all folds' } },
}

utils.create_maps(general_mappings)

-- Snacks plugin keymaps
local snacks_mappings = {
  { 'n', '<leader>fd', '<CMD>lua Snacks.picker.diagnostics()<CR>', { desc = 'Find diagnostics' } },
  { 'v', '<C-f>', '<CMD>lua Snacks.picker.grep_word()<CR>', { desc = 'Find word under cursor' } },
  { 'n', '<C-x>', '<CMD>lua Snacks.bufdelete()<CR>', { desc = 'Delete buffer' } },
}

utils.create_maps(snacks_mappings)

-- File tree keymaps
map('n', '<leader>e', '<CMD>Neotree filesystem toggle<CR>', { desc = 'Toggle file explorer' })

-- Session management
map('n', '<leader>ls', function() require('persistence').load() end, { desc = 'Load session' })

-- Git integration
map('n', '<leader>gg', '<CMD>LazyGit<CR>', { desc = 'Open LazyGit' })

-- Quickfix navigation
local quickfix_mappings = {
  { 'n', '<M-o>', '<CMD>copen<CR>', { desc = 'Open quickfix' } },
  { 'n', '<M-x>', '<CMD>cclose<CR>', { desc = 'Close quickfix' } },
  { 'n', '<M-k>', '<CMD>cprev<CR>', { desc = 'Previous quickfix item' } },
  { 'n', '<M-j>', '<CMD>cnext<CR>', { desc = 'Next quickfix item' } },
}

utils.create_maps(quickfix_mappings)

-- Window resize
map('n', '=', [[<cmd>vertical resize +5<cr>]], { desc = 'Increase window width' })
map('n', '-', [[<cmd>vertical resize -5<cr>]], { desc = 'Decrease window width' })

-- Diffview
local diffview_mappings = {
  { 'n', '<leader>do', '<CMD>DiffviewOpen<CR>', { desc = 'Open diffview' } },
  { 'n', '<leader>df', '<CMD>DiffviewFileHistory %<CR>', { desc = 'Show file history' } },
  { 'n', '<leader>dc', '<CMD>DiffviewClose<CR>', { desc = 'Close diffview' } },
}

utils.create_maps(diffview_mappings)

-- Code utilities
map('n', '<C-a>', '<CMD>SortImports<CR>', { desc = 'Sort Imports by Line Length' })
