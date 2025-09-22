return {
	"nvim-mini/mini.diff",
	event = "BufRead",
	config = function()
		require("mini.diff").setup({
			view = {
				style = "sign",
				signs = { add = "┃", change = "┃", delete = "┃" },
				priority = 199,
			},
		})
	end,
}
