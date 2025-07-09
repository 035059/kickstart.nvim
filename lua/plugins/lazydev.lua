return {
	{
		"folke/lazydev.nvim",
		ft = "lua", -- Only load when editing Lua files
		opts = {
			-- Configure library for completion
			library = {
				-- Load luvit types when the `vim.uv` word is found
				{
					path = "${3rd}/luv/library",
					words = { "vim%.uv" },
				},
			},
			-- Other integrations
			integrations = {
				-- Fixes lspconfig's workspace management for LuaLS
				lspconfig = true,
				-- Use blink.cmp instead of nvim-cmp
				blink = true,
			},
		},
	},
}
