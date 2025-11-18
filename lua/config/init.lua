-- [[ Setting options ]]

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Make line numbers relative
vim.o.relativenumber = true

-- Keep cursor away from edge of screen
vim.o.scrolloff = 16

-- Enable mouse mode
vim.o.mouse = "a"

-- Keep the directory set to the current one
-- vim.opt.autochdir = true

-- Set indent to 2 spaces
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.bo.softtabstop = 2

-- Clipboard disabled for better insert mode performance
-- Use "+y and "+p for explicit system clipboard access
-- See `:help 'clipboard'`

-- Platform-specific clipboard configuration
--[[
if vim.fn.has("wsl") == 1 then
	-- WSL: Use Windows clipboard
	vim.o.clipboard = "unnamedplus"
	vim.g.clipboard = {
		name = "WslClipboard",
		copy = {
			["+"] = "clip.exe",
			["*"] = "clip.exe",
		},
		paste = {
			["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
			["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
		},
		cache_enabled = 0,
	}
elseif vim.fn.has("linux") == 1 then
	-- Linux: Use faster clipboard provider with caching
	vim.o.clipboard = "unnamedplus"
	if vim.fn.executable("xsel") == 1 then
		-- Use xsel (faster than wl-clipboard on some systems)
		vim.g.clipboard = {
			name = "xsel",
			copy = {
				["+"] = "xsel --nodetach -i -b",
				["*"] = "xsel --nodetach -i -p",
			},
			paste = {
				["+"] = "xsel -o -b",
				["*"] = "xsel -o -p",
			},
			cache_enabled = 1,
		}
	end
else
	-- Other platforms (macOS, etc.): Use default
	vim.o.clipboard = "unnamedplus"
end
--]]

-- Enable break indent for linewrapping
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Specify python environment
vim.g.python3_host_prog = "/usr/sbin/python"

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = "yes"

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- Disable Pearl provider
vim.g.loaded_perl_provider = 0

-- Set colorscheme
vim.cmd.colorscheme("tokyonight-night")

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
vim.o.wrap = false
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})
