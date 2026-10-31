--[[
Allin Demopolis neovim config
--]]

vim.g.mapleader = " "
vim.g.maplocalleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- luarocks was built manually with `hererocks.py --no-readline` (no readline-devel here);
-- lazy's own hererocks build would fail, so point it at that install instead.
local rocks_bin = vim.fn.stdpath("data") .. "/lazy-rocks/hererocks/bin"
if vim.uv.fs_stat(rocks_bin .. "/luarocks") then
	vim.env.PATH = rocks_bin .. ":" .. vim.env.PATH
end

require("lazy").setup({
	spec = { { import = "plugins" } },
	rocks = { hererocks = false },
})
require("config")
