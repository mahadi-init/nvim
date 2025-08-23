-- Optimized Neovim options
local opt = vim.opt
Key = vim.keymap.set

-- Performance options
opt.lazyredraw = true -- Don't redraw screen during macros
opt.synmaxcol = 240 -- Avoid syntax highlighting for extremely long lines
opt.winborder = 'rounded'

-- UI Appearance
opt.termguicolors = true -- Enable true color support
opt.showmode = true -- Hide mode indicator (shown in statusline)
opt.relativenumber = true -- Relative line numbers
opt.number = true -- Show current line number
opt.signcolumn = 'yes' -- Always show sign column
vim.o.laststatus = 2
vim.o.ruler = false
opt.wrap = false -- Disable line wrapping
opt.fillchars = { eob = ' ' } -- Remove ~ at end of buffer
opt.scrolloff = 5 -- Keep 5 lines visible when scrolling
opt.splitbelow = true -- Open horizontal splits below
opt.splitright = true -- Open vertical splits to the right
opt.cursorline = false -- Highlight current line

-- Function to get git branch only
function _G.git_branch()
  local handle = io.popen('cd "' .. vim.fn.expand '%:p:h' .. '" && git branch --show-current 2>/dev/null')
  if handle then
    local branch = handle:read '*line'
    handle:close()
    return branch and #branch > 0 and ' ' .. branch or ''
  end
  return ''
end

-- WINBAR: File info and navigation
vim.o.winbar =
  '%#Function# %*%#Comment#%{expand("%:~:h")}/%*%#Title#%t%*%#WarningMsg#%m%*%#Comment# %*%=%#String# %y %*%#Comment#│%*%#Number# %L lines %*'

-- Statusline with just git branch
vim.o.statusline =
  '%#Identifier# %{mode()} %*%#Comment#│%*%#Function#%{v:lua.git_branch()}%*%#Comment# │%*%#Type# %{&ff} %*%#Comment#│%*%#String# %{&fenc?&fenc:&enc} %*%=%#Comment#│%*%#Identifier# %l:%c %*%#Comment#│%*%#Number# %p%% %*%#Comment#│%*%#Function# %{strftime("%H:%M")} %*'

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
opt.hlsearch = false -- Highlight search results
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

-- highlight yanks
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank { higroup = 'IncSearch', timeout = 200 }
  end,
})
