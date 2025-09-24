return {
	"renerocksai/telekasten.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-telescope/telescope.nvim" },
	config = function()
		require("telekasten").setup({
			home = vim.fn.expand("~/zettelkasten"),
		})

		vim.keymap.set("n", "<C-t>", "<CMD>Telekasten panel<CR>")
	end,
}
