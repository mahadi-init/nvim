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
Plug("preservim/nerdtree")
Plug("ryanoasis/vim-devicons")
Plug("tiagofumo/vim-nerdtree-syntax-highlight")
Plug("PhilRunninger/nerdtree-visual-selection")
Plug("j-hui/fidget.nvim")
Plug("kevinhwang91/promise-async")
Plug("kevinhwang91/nvim-ufo")

vim.call("plug#end")

-- Configure and load color scheme
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
opt.foldlevelstart = 99

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
Key("n", "-", [[<cmd>vertical resize -5<cr>]])

-- cycle between buffer
Key("n", "<C-Right>", ":bnext<CR>", { desc = "Next buffer" })
Key("n", "<C-Left>", ":bprevious<CR>", { desc = "Previous buffer" })
Key("n", "<C-x>", ":bd<CR>", { desc = "delete buffer" })

-- move lines
Key("n", "<M-Up>", ":m .-2<CR>==", { desc = "Move line up" })
Key("v", "<M-Up>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
Key("n", "<M-Down>", ":m .+1<CR>==", { desc = "Move line down" })
Key("v", "<M-Down>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })

-- nerdtree
Key("n", "<C-a>", ":NERDTreeToggle<CR>", { desc = "file explorer" })

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
Key("n", "<C-b>", builtin.buffers, { desc = "Telescope buffers" })
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

if lsp_status and blink_status then
	local capabilities = blink.get_lsp_capabilities()

	local on_attach = function(_, bufnr)
		local opts = { noremap = true, silent = true, buffer = bufnr }

		-- LSP keymaps
		vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, opts)
		vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "<leader>ll", function()
			vim.diagnostic.setqflist({ severity = { min = vim.diagnostic.severity.WARN } })
		end, opts)
		vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
		vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
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
		-- Enable and clear cursors using escape.
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
		open_mapping = [[<c-`>]],
		direction = "float",
	})
end

-- fidget
local fidget_status, fidget = pcall(require, "fidget")
if fidget_status then
	fidget.setup({})
end

-- ufo
local ufo_status, ufo = pcall(require, "ufo")
if ufo_status then
	ufo.setup({
		provider_selector = function()
			return { "treesitter", "indent" }
		end,
	})

	-- Set up key mappings
	Key("n", "zz", "za", {
		noremap = false,
		silent = true,
		desc = "Center screen and toggle fold",
	})
end
