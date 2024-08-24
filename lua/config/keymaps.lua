local builtin = require("telescope.builtin")

-- telescope
vim.keymap.set("n", "<leader><leader>", builtin.find_files)
vim.keymap.set("n", "<leader>fg", builtin.live_grep) -- live grep
vim.keymap.set("n", "<leader>fb", builtin.buffers)   -- view buffers

-- oil
vim.keymap.set("n", "-", "<CMD>Oil<CR>") -- oil open parent dir

-- basic
vim.keymap.set("n", "<C-s>", "<CMD>w<CR>")          -- save file
vim.keymap.set("i", "<C-s>", "<CMD>w<CR>")          -- save file
vim.keymap.set("n", "<leader>q", "<CMD>q<CR>")      -- quit neovim
vim.keymap.set("n", "<ESC>", "<CMD>nohlsearch<CR>") -- escape and remove search query
vim.keymap.set("n", "<C-n>", "<CMD>bnext<CR>")      -- next buffer
vim.keymap.set("n", "<C-p>", "<CMD>bprevious<CR>")  -- previous buffer
vim.keymap.set("n", "<C-x>", "<CMD>bd<CR>")         -- delete buffer
vim.keymap.set("n", "<C-d>", "<C-d>zz")             -- upward
vim.keymap.set("n", "<C-u>", "<C-u>zz")             -- downward

-- split
vim.keymap.set("n", "<C-v>", "<CMD>vsplit<CR>") -- split vertical

-- diagnostic
local diagnostic = vim.diagnostic
vim.keymap.set("n", "[d", diagnostic.goto_prev)          -- previous diagnostic
vim.keymap.set("n", "]d", diagnostic.goto_next)          -- next diagnostic
vim.keymap.set("n", "<leader>ld", diagnostic.open_float) -- open float diagnostic
vim.keymap.set("n", "<leader>lq", diagnostic.setloclist) -- open float diagnostic

-- todo comments
vim.keymap.set("n", "<leader>ff", "<CMD>TodoQuickFix<CR>")  -- todo quickfix
vim.keymap.set("n", "<leader>fl", "<CMD>TodoLocList<CR>")   -- todo locallist
vim.keymap.set("n", "<leader>ft", "<CMD>TodoTelescope<CR>") -- todo telescope

-- codeium
vim.api.nvim_set_keymap("n", "<leader>cc", ":call codeium#Chat()<CR>", { noremap = true, silent = true })

-- session
vim.api.nvim_set_keymap("n", "<leader>ss", ":SessionSave<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>sr", ":SessionRestore<CR>", { noremap = true, silent = true })
