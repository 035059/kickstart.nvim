return {
	-- test
	"folke/tokyonight.nvim",
	config = function()
		require("tokyonight").setup({
			on_colors = function(colors)
				colors.comment = "#8f95b8"
			end,
		})
	end,
}
