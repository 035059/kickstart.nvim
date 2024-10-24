local wk = require("which-key")

-- [[ Which-key Configurations ]]
-- document existing key chains

-- register which-key VISUAL mode
-- required for visual <leader>hs (hunk stage) to work
wk.add({
	{ "<leader>", group = "VISUAL <leader>", mode = "v" },
	{ "<leader>h", desc = "Git Hunk", mode = "v" },
})

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- Oil keybinds
vim.keymap.set("n", "-", "<CMD>Oil --float<CR>", { desc = "Open parent directory" })

-- Nabla (inline math)
vim.keymap.set("n", "<leader>p", require("nabla").popup, { desc = "Show math popup" })
vim.keymap.set("n", "<leader>P", require("nabla").toggle_virt, { desc = "Toggle global math" })

-- Harpoon keybinds (alt not 'A')
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")
vim.keymap.set("n", "<A-h>", mark.add_file)
vim.keymap.set("n", "<A-u>", ui.toggle_quick_menu)

vim.keymap.set("n", "<A-j>", function()
	ui.nav_file(1)
end)
vim.keymap.set("n", "<A-k>", function()
	ui.nav_file(2)
end)
vim.keymap.set("n", "<A-l>", function()
	ui.nav_file(3)
end)
vim.keymap.set("n", "<A-;>", function()
	ui.nav_file(4)
end)

-- Spell Check keybinds

wk.add({
	{ "<leader>p", group = "Spellcheck" },
	{ "<leader>po", "<CMD>setlocal spell spelllang=en_ca<CR>", desc = "Start Spellcheck" },
})

-- Copilot keybinds
vim.keymap.set("i", "<S-Tab>", 'copilot#Accept("\\<CR>")', {
	expr = true,
	replace_keycodes = false,
})
vim.g.copilot_no_tab_map = true

-- Git keybinds
local function git_commit()
	vim.cmd(string.format('Git commit -m "%s"', vim.fn.input("Commit message: ")))
end
-- c = {
-- 	function()
-- 		git_commit()
-- 	end,
-- 	"Create commit",
-- },
wk.add({
	{ "<leader>g", group = "Git" },
	{ "<leader>ga", "<CMD>Git add %<CR>", desc = "Add file to git tracking" },
	{ "<leader>gA", "<CMD>Git add *<CR>", desc = "Add all files to git tracking" },
	{
		"<leader>gc",
		function()
			git_commit()
		end,
		desc = "Create commit",
	},
	{ "<leader>p", "<CMD>Git push<CR>", desc = "Push to remote" },
	{ "<leader>P", "<CMD>Git pull<CR>", desc = "Pull from remote" },
	{ "<leader>s", "<CMD>Git status<CR>", desc = "Get git status" },
})

-- Comment.nvim keybinds
local api = require("Comment.api")
local comment = require("Comment.config"):get()

vim.keymap.set("n", "<C-/>", api.toggle.linewise.current)
vim.keymap.set("n", "<C-.>", api.toggle.blockwise.current)

-- Telescope keymaps
-- See `:help telescope.builtin`
vim.keymap.set("n", "<leader>?", require("telescope.builtin").oldfiles, { desc = "Find recently opened files" })
vim.keymap.set("n", "<leader><space>", require("telescope.builtin").buffers, { desc = "Find existing buffers" })
vim.keymap.set("n", "<leader>/", function()
	-- You can pass additional configuration to telescope to change theme, layout, etc.
	require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = false,
	}))
end, { desc = "Fuzzily search in current buffer" })

local function telescope_live_grep_open_files()
	require("telescope.builtin").live_grep({
		grep_open_files = true,
		prompt_title = "Live Grep in Open Files",
	})
end
local tb = require("telescope.builtin")
vim.keymap.set("n", "<leader>s/", telescope_live_grep_open_files, { desc = "Search in Open Files" })
vim.keymap.set("n", "<leader>ss", tb.builtin, { desc = "Search Select Telescope" })
vim.keymap.set("n", "<leader>gf", tb.git_files, { desc = "Search Git Files" })
vim.keymap.set("n", "<leader>sf", tb.find_files, { desc = "Search Files" })
vim.keymap.set("n", "<leader>sh", tb.help_tags, { desc = "Search Help" })
vim.keymap.set("n", "<leader>sw", tb.grep_string, { desc = "Search current Word" })
vim.keymap.set("n", "<leader>sg", tb.live_grep, { desc = "Search by Grep" })
vim.keymap.set("n", "<leader>sG", ":LiveGrepGitRoot<cr>", { desc = "Search by Grep on Git Root" })
vim.keymap.set("n", "<leader>sd", tb.diagnostics, { desc = "Search Diagnostics" })
vim.keymap.set("n", "<leader>sr", tb.resume, { desc = "Search Resume" })
