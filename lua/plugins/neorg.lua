local M = {
	"nvim-neorg/neorg",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-treesitter/nvim-treesitter-textobjects",
		"nvim-cmp",
		"nvim-lua/plenary.nvim",
	},
	build = ":Neorg sync-parsers",
	-- tag = "*",
	lazy = true, -- enable lazy load
	ft = "norg", -- lazy load on file type
	cmd = "Neorg", -- lazy load on command
}

local modules = {
	["core.defaults"] = {}, -- Loads default behaviour
	["core.completion"] = { config = { engine = "nvim-cmp", name = "[Norg]" } },
	["core.integrations.nvim-cmp"] = {},
	["core.concealer"] = { -- Adds pretty icons to documents
		config = {
			icon_preset = "diamond",
			conceallevel = 3,
			init_open_folds = "auto",
		},
	},
	["core.keybinds"] = {
		config = {
			default_keybinds = true,
			neorg_leader = "<Leader><Leader>",
		},
	},
	["core.dirman"] = { -- Manages Neorg workspaces
		config = {
			workspaces = {
				personal = "~/notes/personal/",
				school = "~/notes/school/",
			},
		},
	},
}

M.opts = {
	load = modules,
}

return M
