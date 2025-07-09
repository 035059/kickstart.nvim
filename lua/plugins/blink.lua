return {
	-- blink.cmp for completion
	"saghen/blink.cmp",
	dependencies = {
		"rafamadriz/friendly-snippets",
	},
	version = "1.*",
	config = function()
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
