return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			options = {
				theme = "auto",
				icons_enabled = not vim.g.started_by_firenvim,
				component_separators = vim.g.started_by_firenvim and { left = "|", right = "|" }
					or { left = "", right = "" },
				section_separators = vim.g.started_by_firenvim and { left = "", right = "" }
					or { left = "", right = "" },
			},
		})
	end,
}
