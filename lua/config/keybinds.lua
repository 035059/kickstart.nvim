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
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Nabla (inline math)
vim.keymap.set("n", "<leader>p", require("nabla").popup, { desc = "Show math popup" })
vim.keymap.set("n", "<leader>P", require("nabla").toggle_virt, { desc = "Toggle global math" })

-- Toggleterm keybinds
function _G.set_terminal_keymaps()
	local opts = { buffer = 0 }
	vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
	vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
	vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
	vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
	vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
	vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
	vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
end
vim.cmd("autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()")

-- Twiddlecase (cycles selection between UPPER CASE, lower case, and Title Case)
local function twiddle_case(str)
	if str == string.upper(str) then
		return string.lower(str)
	elseif str == string.lower(str) then
		return string.gsub(str, "(%w)(%w*)", function(first, rest)
			return string.upper(first) .. rest
		end)
	else
		return string.upper(str)
	end
end

-- Register the function globally so it can be called from Vimscript
_G.twiddle_case = twiddle_case

-- Set up the mapping
vim.api.nvim_set_keymap(
	"v",
	"~",
	[[y<cmd>lua vim.fn.setreg('', _G.twiddle_case(vim.fn.getreg('"')), vim.fn.getregtype(''))<CR>gv""Pgv]],
	{ noremap = true, silent = true }
)

-- Spell Check keybinds
wk.add({
	{ "<leader>po", "<CMD>setlocal spell spelllang=en_ca<CR>", desc = "Start Spellcheck" },
})

-- Git keybinds
local function git_commit()
	vim.cmd(string.format('Git commit -m "%s"', vim.fn.input("Commit message: ")))
end
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
	{ "<leader>gp", "<CMD>Git push<CR>", desc = "Push to remote" },
	{ "<leader>gP", "<CMD>Git pull<CR>", desc = "Pull from remote" },
	{ "<leader>gs", "<CMD>Git status<CR>", desc = "Get git status" },
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
vim.keymap.set("n", "<leader>sk", tb.keymaps, { desc = "Search Keymaps" })
