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
		open_mapping = [[<C-t>]],
		winbar = {
			enabled = true,
		},
	},
	config = function(_, opts)
		require("toggleterm").setup(opts)
		-- Mapping to vertical split terminal
		vim.api.nvim_set_keymap(
			"n",
			"<A-t>",
			"<cmd>ToggleTerm direction=vertical<CR>",
			{ noremap = true, silent = true }
		)
		-- Mapping to horizontal split terminal
		vim.api.nvim_set_keymap(
			"n",
			"<C-t>",
			"<cmd>ToggleTerm direction=horizontal<CR>",
			{ noremap = true, silent = true }
		)
	end,
}
