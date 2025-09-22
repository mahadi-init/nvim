local vim = vim
key = vim.keymap.set
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
local Plug = vim.fn["plug#"]

vim.call("plug#begin")

-- Color Schemes
Plug("jake-stewart/multicursor.nvim")
Plug("nvim-mini/mini.diff")
Plug("j-hui/fidget.nvim")
Plug("chrisgrieser/nvim-origami")

vim.call("plug#end")

-- multicursor
local multicursor_status, multicursor = pcall(require, "multicursor-nvim")
if multicursor_status then
	multicursor.setup()

	-- Add and remove cursors with alt + left click.
	key("n", "<M-leftmouse>", multicursor.handleMouse)
	key("x", "<C-o>", function()
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

	key("n", "zz", "za", {
		noremap = false,
		silent = true,
		desc = "Center screen and toggle fold",
	})
end
