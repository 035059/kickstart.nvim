return {
	"akinsho/nvim-toggleterm.lua",
	opts = {
		-- size can be a number or function which is passed the current terminal
		size = function(term)
			if term.direction == "horizontal" then
				return 15
			elseif term.direction == "vertical" then
				return vim.o.columns * 0.4
			end
		end,
		autochdir = true,
	},
}
