return {
	-- blink.cmp for completion
	"saghen/blink.cmp",
	dependencies = {
		"rafamadriz/friendly-snippets",
		"L3MON4D3/LuaSnip",
	},
	version = "1.*",
	config = function()
		-- Load your custom LuaSnip snippets
		require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/snippets"})
		
		require("blink.cmp").setup({
			-- Keymap
			keymap = { preset = "super-tab" },
			-- Configure completion sources
			sources = {
				default = {
					"lsp",
					"path",
					"snippets",
					"buffer",
				},
			},
			-- Configure the appearance of the completion menu
			completion = {
				documentation = {
					auto_show = true,
				},
				menu = {
					draw = {
						treesitter = {
							enabled = true,
						},
					},
				},
			},
		})
	end,
}
