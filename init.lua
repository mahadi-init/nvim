local vim = vim
local opt = vim.opt
Key = vim.keymap.set
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
local Plug = vim.fn["plug#"]

vim.call("plug#begin")

-- Color Schemes
Plug("dracula/vim", { ["as"] = "dracula" })
Plug("nvim-treesitter/nvim-treesitter", { ["do"] = ":TSUpdate" })
Plug("nvim-tree/nvim-web-devicons")
Plug("nvim-lua/plenary.nvim")
Plug("nvim-telescope/telescope.nvim")
Plug("neovim/nvim-lspconfig")
Plug("williamboman/mason.nvim")
Plug("williamboman/mason-lspconfig.nvim")
Plug("saghen/blink.cmp")
Plug("stevearc/conform.nvim")
Plug("windwp/nvim-ts-autotag")
Plug("axelvc/template-string.nvim")
Plug("Raimondi/delimitMate")
Plug("lukas-reineke/indent-blankline.nvim")
Plug("kdheepak/lazygit.nvim")
Plug("jake-stewart/multicursor.nvim")
Plug("nvim-mini/mini.diff")
Plug("akinsho/toggleterm.nvim")
Plug("mikavilpas/yazi.nvim")
Plug("j-hui/fidget.nvim")
Plug("chrisgrieser/nvim-origami")
Plug("stevearc/dressing.nvim")

vim.call("plug#end")

-- Configure and load color scheme
vim.g.dracula_italic = 0
vim.opt.background = "dark"
vim.cmd("silent! colorscheme dracula")

-- Settings
opt.clipboard = "unnamedplus"
opt.termguicolors = true
opt.winborder = "rounded"
opt.relativenumber = true
opt.number = true
opt.wrap = false
opt.fillchars = { eob = " " }
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
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.g.loaded_netrwPlugin = 1

-- Diagnostics appearance
vim.diagnostic.config({
	virtual_text = true,
	signs = false,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		border = "rounded",
		source = "always",
	},
})

-- Keymps (Basic)
Key({ "n", "i", "v" }, "<C-s>", "<CMD>w<CR>")
Key("n", "<ESC>", "<CMD>nohlsearch<CR>")
Key("n", "<C-v>", "<CMD>leftabove vsplit<CR>")

-- QuickFix
Key("n", "<M-o>", "<CMD>copen<CR>", { desc = "Open quickfix" })
Key("n", "<M-x>", "<CMD>cclose<CR>", { desc = "close quickfix" })
Key("n", "<M-k>", "<CMD>cprev<CR>", { desc = "previous quickfix" })
Key("n", "<M-j>", "<CMD>cnext<CR>", { desc = "next quickfix" })

-- resize window
Key("n", "=", [[<cmd>vertical resize +5<cr>]])
-- Key("n", "-", [[<cmd>vertical resize -5<cr>]])

-- cycle between buffer
Key("n", "<C-Right>", ":bnext<CR>", { desc = "Next buffer" })
Key("n", "<C-Left>", ":bprevious<CR>", { desc = "Previous buffer" })
Key("n", "<C-x>", ":bd<CR>", { desc = "delete buffer" })

-- move lines
Key("n", "<M-Up>", ":m .-2<CR>==", { desc = "Move line up" })
Key("v", "<M-Up>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
Key("n", "<M-Down>", ":m .+1<CR>==", { desc = "Move line down" })
Key("v", "<M-Down>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })

-- Yazi.nvim configuration
local yazi_status, yazi = pcall(require, "yazi")
if yazi_status then
	yazi.setup({
		open_for_directories = true,
	})

	-- Set up key mappings
	Key("n", "-", "<cmd>Yazi<CR>", {
		noremap = true,
		silent = true,
		desc = "Open yazi at the current file",
	})
	Key("v", "-", "<cmd>Yazi<CR>", {
		noremap = true,
		silent = true,
		desc = "Open yazi at the current file",
	})

	-- Folders only function
	local function folders_only()
		local fd_cmd = "fdfind --type d --hidden --exclude .git"
		local fd_handle = io.popen(fd_cmd)
		local results = {}

		if fd_handle then
			for line in fd_handle:lines() do
				local abs_path = vim.fn.fnamemodify(line, ":p")
				local display = line .. "/"
				table.insert(results, { path = abs_path, display = display })
			end
			fd_handle:close()
		end

		-- add project root (cwd) at the very top
		local cwd = vim.fn.getcwd()
		table.insert(results, 1, {
			path = cwd,
			display = "root",
		})

		vim.ui.select(results, {
			prompt = "Folders:",
			format_item = function(item)
				return item.display
			end,
		}, function(selected)
			if not selected then
				return
			end

			require("yazi").yazi({}, selected.path)
		end)
	end

	-- Set up key mapping for folders only
	vim.api.nvim_set_keymap("n", "<C-e>", "", {
		noremap = true,
		silent = true,
		desc = "Folders only (Yazi compatible)",
		callback = folders_only,
	})
end

-- Autocmds (highlight yanks)
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
	end,
})

local lazygit_status = pcall(require, "lazygit")
if lazygit_status then
	Key("n", "<leader>gg", "<CMD>LazyGit<CR>", { desc = "LazyGit" }) -- file tree
end

-- Indent Blankline
local indent_status, indent_blankline = pcall(require, "ibl")
if indent_status then
	indent_blankline.setup({
		scope = { enabled = false },
	})
end

-- telescope
local telescope_status, telescope = pcall(require, "telescope")

if telescope_status then
	telescope.setup({
		defaults = {
			path_display = {
				filename_first = {
					reverse_directories = true,
				},
			},
			prompt_prefix = "   ",
			selection_caret = " ❯ ",
			layout_strategy = "horizontal",
			layout_config = { prompt_position = "top" },
			sorting_strategy = "ascending",
			winblend = 0,
			preview = {
				-- hide_on_startup = true,
			},
			file_ignore_patterns = {
				"node_modules",
				".next",
				"package-lock.json",
				"bun.lock",
				"pnpm-lock.yaml",
			},
		},
		pickers = {
			find_files = {
				find_command = { "rg", "--files", "--sortr=modified" },
			},
		},
	})
end

local builtin = require("telescope.builtin")
Key("n", "<leader><leader>", builtin.find_files, { desc = "find files" })
Key("n", "<C-/>", builtin.live_grep, { desc = "Telescope live grep" })
Key("n", "<C-l>", builtin.buffers, { desc = "Telescope buffers" })
Key("n", "<C-g>", builtin.git_status, { desc = "git status" })

-- mason
local mason_status, mason = pcall(require, "mason")
if mason_status then
	mason.setup({})
end

-- mason lsp
local mason_lsp_status, mason_lsp = pcall(require, "mason-lspconfig")
if mason_lsp_status then
	mason_lsp.setup({})
end

-- LSP Configuration
local lsp_status, lspconfig = pcall(require, "lspconfig")
local blink_status, blink = pcall(require, "blink.cmp")
local capabilities = blink.get_lsp_capabilities()

if lsp_status and blink_status then
	local on_attach = function(_, bufnr)
		local opts = { noremap = true, silent = true, buffer = bufnr }

		-- LSP keymaps
		Key("n", "<leader>lr", vim.lsp.buf.rename, opts)
		Key("n", "<leader>la", vim.lsp.buf.code_action, opts)
		Key("n", "<leader>ld", vim.diagnostic.open_float, opts)
		Key("n", "K", vim.lsp.buf.hover, opts)
		Key("n", "gd", builtin.lsp_definitions, opts)
		Key("n", "gr", builtin.lsp_references, opts)
		Key("n", "gs", builtin.lsp_document_symbols)
		Key("n", "<leader>ll", function()
			builtin.diagnostics({ bnfnr = 0 })
		end, opts)
		Key("n", "[d", vim.diagnostic.goto_prev, opts)
		Key("n", "]d", vim.diagnostic.goto_next, opts)
	end

	-- List of servers
	local servers = {
		"lua_ls",
		"ts_ls",
		"eslint",
		"tailwindcss",
		"html",
		"cssls",
		"bashls",
	}

	-- Server setup
	for _, lsp in ipairs(servers) do
		lspconfig[lsp].setup({
			on_attach = on_attach,
			capabilities = capabilities,
		})
	end
end

-- blink cmp
if blink_status then
	blink.setup({
		keymap = {
			preset = "none",
			["<CR>"] = { "accept", "fallback" },
			["<S-Tab>"] = { "hide", "fallback" },
			["<Tab>"] = { "select_next", "fallback" },
			["<Down>"] = { "select_next", "fallback" },
			["<Up>"] = { "select_prev", "fallback" },
			["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
		},
		appearance = {
			use_nvim_cmp_as_default = true,
			nerd_font_variant = "mono",
		},
		sources = {
			default = { "lsp", "buffer", "path", "snippets" },
		},
		completion = {
			accept = { auto_brackets = { enabled = false } },
			menu = {
				draw = {
					columns = {
						{ "kind_icon", "label", "label_description", gap = 1 },
					},
					treesitter = { "lsp" },
					components = {
						label = {
							text = function(ctx)
								return ctx.item.label
							end,
							highlight = function(ctx)
								return ctx.highlights
							end,
						},
					},
				},
			},
			documentation = { auto_show = true, auto_show_delay_ms = 500 },
		},
	})
end

-- Conform.nvim configuration
local conform_status, conform = pcall(require, "conform")
if conform_status then
	local prettier_formatters = {
		"prettierd",
		"prettier",
		stop_after_first = true,
	}

	conform.setup({
		formatters_by_ft = {
			lua = { "stylua" },
			javascript = prettier_formatters,
			typescript = prettier_formatters,
			typescriptreact = prettier_formatters,
			html = prettier_formatters,
			css = prettier_formatters,
			json = prettier_formatters,
		},
		format_after_save = {
			lsp_format = "fallback",
		},
	})
end

-- Nvim-ts-autotag
local auto_tag_status, auto_tag = pcall(require, "nvim-ts-autotag")
if auto_tag_status then
	auto_tag.setup({
		opts = {
			enable_close = true,
			enable_rename = true,
			enable_close_on_slash = true,
		},
	})
end

-- Template String configuration
local template_string_status, template_string = pcall(require, "template-string")
if template_string_status then
	template_string.setup({
		filetypes = {
			"html",
			"typescript",
			"javascript",
			"typescriptreact",
			"javascriptreact",
		},
		jsx_brackets = true,
		remove_template_string = true,
		restore_quotes = {
			normal = [[']],
			jsx = [["]],
			tsx = [["]],
		},
	})
end

-- multicursor
local multicursor_status, multicursor = pcall(require, "multicursor-nvim")
if multicursor_status then
	multicursor.setup()

	-- Add and remove cursors with alt + left click.
	Key("n", "<M-leftmouse>", multicursor.handleMouse)
	Key("x", "<C-o>", function()
		multicursor.matchAddCursor(1)
	end)

	-- Mappings defined in a keymap layer only apply when there are
	-- multiple cursors. This lets you have overlapping mappings.
	multicursor.addKeymapLayer(function(layerSet)
		layerSet("n", "<esc>", function()
			if not multicursor.cursorsEnabled() then
				multicursor.enableCursors()
			else
				multicursor.clearCursors()
			end
		end)
	end)
end

-- mini diff
local mini_diff_status, mini_diff = pcall(require, "mini.diff")
if mini_diff_status then
	mini_diff.setup({
		view = {
			style = "sign",
			signs = { add = "┃", change = "┃", delete = "┃" },
			priority = 199,
		},
	})
end

-- toggle term
local toggle_term_status, toggleterm = pcall(require, "toggleterm")
if toggle_term_status then
	toggleterm.setup({
		open_mapping = [[<c-t>]],
		direction = "float",
	})
end

-- fidget
local fidget_status, fidget = pcall(require, "fidget")
if fidget_status then
	fidget.setup({})
end

-- fold origami
local origami_status, origami = pcall(require, "origami")
if origami_status then
	origami.setup({
		useLspFoldsWithTreesitterFallback = true,
		pauseFoldsOnSearch = true,
		foldtext = {
			enabled = true,
			padding = 3,
			lineCount = {
				template = "%d lines", -- `%d` is replaced with the number of folded lines
				hlgroup = "Comment",
			},
			diagnosticsCount = true, -- uses hlgroups and icons from `vim.diagnostic.config().signs`
			gitsignsCount = true, -- requires `gitsigns.nvim`
		},
		autoFold = {
			enabled = false,
		},
		foldKeymaps = {
			setup = false,
			hOnlyOpensOnFirstColumn = false,
		},
	})

	Key("n", "zz", "za", {
		noremap = false,
		silent = true,
		desc = "Center screen and toggle fold",
	})
end
