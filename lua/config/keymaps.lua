local builtin = require('telescope.builtin')

-- telescope
-- vim.keymap.set('n', '<leader><leader>', builtin.find_files, {})
vim.keymap.set('n', '<leader><leader>', "<CMD>Telescope frecency workspace=CWD<CR>") -- open telescope
vim.keymap.set('n', '<leader>fg', builtin.live_grep)                                 -- live grep
vim.keymap.set('n', '<leader>fb', builtin.buffers)                                   -- view buffers

-- oil
vim.keymap.set("n", "-", "<CMD>Oil<CR>") -- oil open parent dir

-- basic
vim.keymap.set("n", "<C-s>", "<CMD>w<CR>")          -- save file
vim.keymap.set("n", "<leader>q", "<CMD>q<CR>")      -- quit neovim
vim.keymap.set("n", "<ESC>", "<CMD>nohlsearch<CR>") -- quit neovim

-- split
vim.keymap.set("n", "<C-v>", "<CMD>vsplit<CR>") -- split vertical
vim.keymap.set("n", "<C-x>", "<CMD>close<CR>")  -- close split
vim.keymap.set("n", "<C-X>", "<CMD>only<CR>")   -- close all splits

-- diagnostic
local diagnostic = vim.diagnostic
vim.keymap.set("n", "[d", diagnostic.goto_prev)          -- previous diagnostic
vim.keymap.set("n", "]d", diagnostic.goto_next)          -- next diagnostic
vim.keymap.set("n", "<leader>ld", diagnostic.open_float) -- open float diagnostic
vim.keymap.set("n", "<leader>lq", diagnostic.setloclist) -- open float diagnostic

-- harpoon
local harpoon = require("harpoon")
harpoon:setup()

-- basic telescope configuration
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
  local file_paths = {}
  for _, item in ipairs(harpoon_files.items) do
    table.insert(file_paths, item.value)
  end

  require("telescope.pickers").new({}, {
    prompt_title = "Harpoon",
    finder = require("telescope.finders").new_table({
      results = file_paths,
    }),
    previewer = conf.file_previewer({}),
    sorter = conf.generic_sorter({}),
  }):find()
end

vim.keymap.set("n", "<C-f>", function() harpoon:list():add() end)
vim.keymap.set("n", "<C-l>", function() toggle_telescope(harpoon:list()) end,
  { desc = "Open harpoon window" })

vim.keymap.set("n", "<C-y>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<C-u>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<C-i>", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<C-o>", function() harpoon:list():select(4) end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<C-p>", function() harpoon:list():prev() end)
vim.keymap.set("n", "<C-n>", function() harpoon:list():next() end)
