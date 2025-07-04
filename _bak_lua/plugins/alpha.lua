return {
	"goolord/alpha-nvim",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"MaximilianLloyd/ascii.nvim",
	},
	config = function()
		require("config/alpha-config")
	end,
}
