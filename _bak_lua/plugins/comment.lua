return {
	"numToStr/Comment.nvim",
	opts = {},
	lazy = false,
	config = function()
		require("Comment").setup({
			mappings = { basic = false, extra = false },
		})
	end,
}
