local telescope = require 'telescope.builtin'
require('configs.import-format').setup()

-- native keymaps
vim.keymap.set({ 'n', 'i', 'v' }, '<C-s>', '<CMD>w<CR>') -- save file
vim.keymap.set('n', '<leader>q', '<CMD>q<CR>') -- quit neovim
vim.keymap.set('n', '<ESC>', '<CMD>nohlsearch<CR>') -- escape and remove search query
vim.keymap.set('n', '<C-j>', '<C-d>zz') -- scroll down
vim.keymap.set('n', '<C-k>', '<C-u>zz') -- scroll up
vim.keymap.set('n', '<C-d>', '<C-d>zz') -- scroll down
vim.keymap.set('n', '<C-u>', '<C-u>zz') -- scroll up
vim.keymap.set('n', '<C-v>', '<CMD>vsplit<CR>') -- vertical split
vim.keymap.set('n', '<C-Right>', '<CMD>BufferLineCycleNext<CR>') -- next buffer
vim.keymap.set('n', '<C-Left>', '<CMD>BufferLineCyclePrev<CR>') -- previous buffer

-- telescope
vim.keymap.set('n', '<leader><leader>', telescope.find_files, { desc = 'find files' }) -- find files
vim.keymap.set('n', '<C-g>', function()
  telescope.git_status {
    initial_mode = 'normal', -- Start in normal mode
    path_display = function(_, path)
      return vim.fn.fnamemodify(path, ':h:t') .. '/' .. vim.fn.fnamemodify(path, ':t')
    end,
  }
end, { desc = 'git status' }) -- git status
vim.keymap.set('n', '<leader>fw', telescope.live_grep, { desc = 'find words' }) -- live grep
vim.keymap.set('n', '<C-b>', function()
  telescope.buffers {
    initial_mode = 'normal', -- Start in normal mode
    path_display = function(_, path)
      return vim.fn.fnamemodify(path, ':h:t') .. '/' .. vim.fn.fnamemodify(path, ':t')
    end,
  }
end, { desc = 'Find buffer' })
vim.keymap.set('n', '<leader>ft', telescope.current_buffer_fuzzy_find) -- find text current buffer

-- snacks
vim.keymap.set('n', '<leader>fd', '<CMD>lua Snacks.picker.diagnostics()<CR>', { desc = 'find errors' }) -- find buffers
vim.keymap.set('v', '<C-f>', '<CMD>lua Snacks.picker.grep_word()<CR>', { desc = 'find word' }) -- find buffers
vim.keymap.set('n', '<C-x>', '<CMD>lua Snacks.bufdelete()<CR>', { desc = 'Delete buffer' })

-- file tree
vim.keymap.set('n', '<leader>e', '<CMD>Neotree filesystem toggle<CR>', { desc = 'neo tree open' }) -- file tree

-- session
vim.keymap.set('n', '<leader>ls', function()
  require('persistence').load()
end)

-- lazygit
vim.keymap.set('n', '<leader>gg', '<CMD>LazyGit<CR>', { desc = 'LazyGit' }) -- file tree

-- quickfix
vim.keymap.set('n', '<M-c>', '<CMD>copen<CR>', { desc = 'Open quickfix' })
vim.keymap.set('n', '<M-x>', '<CMD>cclose<CR>', { desc = 'close quickfix' })
vim.keymap.set('n', '<M-k>', '<CMD>cprev<CR>', { desc = 'previous quickfix' })
vim.keymap.set('n', '<M-j>', '<CMD>cnext<CR>', { desc = 'next quickfix' })
vim.keymap.set('n', '<M-t>', '<CMD>TodoQuickFix<CR>', { desc = 'quickfix todo list' })

-- resize window
vim.keymap.set('n', '=', [[<cmd>vertical resize +5<cr>]]) -- make the window biger vertically
vim.keymap.set('n', '-', [[<cmd>vertical resize -5<cr>]]) -- make the window smaller vertically

-- diffview
vim.keymap.set('n', '<leader>do', '<CMD>DiffviewOpen<CR>')
vim.keymap.set('n', '<leader>df', '<CMD>DiffviewFileHistory %<CR>')
vim.keymap.set('n', '<leader>dc', '<CMD>DiffviewClose<CR>')

-- bufferline
vim.keymap.set('n', '<Leader>bp', '<cmd>BufferLineTogglePin<CR>')

-- Set up a keymap to trigger the sorting
vim.keymap.set('n', '<C-a>', '<CMD>SortImports<CR>', { desc = 'Sort Imports by Line Length' })

-- ssr
vim.keymap.set({ 'n' }, '<c-f>', function()
  require('ssr').open()
end)

-- Add this to your Neovim config
local function vimwiki_search()
  require('telescope.builtin').live_grep {
    search_dirs = { vim.fn.expand '~/vimwiki' }, -- adjust path to your wiki
  }
end

vim.keymap.set('n', '<leader>wws', vimwiki_search, { desc = 'Search Vimwiki' })
