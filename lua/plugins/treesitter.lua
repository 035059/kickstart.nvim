local ensure_installed = {
	"c",
	"cpp",
	"go",
	"lua",
	"latex",
	"python",
	"rust",
	"tsx",
	"javascript",
	"typescript",
	"vimdoc",
	"vim",
	"bash",
}

-- vimtex handles highlighting and indent for these
local no_highlight = { latex = true }

return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			local ts = require("nvim-treesitter")
			ts.install(ensure_installed)

			local function attach(buf, lang)
				if not pcall(vim.treesitter.start, buf, lang) then
					return false
				end
				if vim.treesitter.query.get(lang, "indents") then
					vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end
				return true
			end

			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("UserTreesitter", { clear = true }),
				callback = function(ev)
					local lang = vim.treesitter.language.get_lang(ev.match)
					if not lang or no_highlight[lang] or attach(ev.buf, lang) then
						return
					end
					if vim.list_contains(ts.get_available(), lang) then
						ts.install(lang):await(function()
							vim.schedule(function()
								if vim.api.nvim_buf_is_valid(ev.buf) then
									attach(ev.buf, lang)
								end
							end)
						end)
					end
				end,
			})

			-- Built-in node selection (:h treesitter-incremental-selection)
			vim.keymap.set("n", "<C-space>", "van", { remap = true, desc = "Select treesitter node" })
			vim.keymap.set("x", "<C-space>", "an", { remap = true, desc = "Expand node selection" })
			vim.keymap.set("x", "<M-space>", "in", { remap = true, desc = "Shrink node selection" })
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		init = function()
			-- These runtime ftplugins define buffer-local ]] / ]m maps that would shadow ours
			vim.g.no_python_maps = true
			vim.g.no_rust_maps = true
			vim.g.no_go_maps = true
		end,
		config = function()
			require("nvim-treesitter-textobjects").setup({
				select = { lookahead = true },
				move = { set_jumps = true },
			})

			local select = require("nvim-treesitter-textobjects.select")
			for lhs, query in pairs({
				aa = "@parameter.outer",
				ia = "@parameter.inner",
				af = "@function.outer",
				["if"] = "@function.inner",
				ac = "@class.outer",
				ic = "@class.inner",
			}) do
				vim.keymap.set({ "x", "o" }, lhs, function()
					select.select_textobject(query, "textobjects")
				end, { desc = "Select " .. query })
			end

			local move = require("nvim-treesitter-textobjects.move")
			for lhs, spec in pairs({
				["]m"] = { move.goto_next_start, "@function.outer" },
				["]]"] = { move.goto_next_start, "@class.outer" },
				["]M"] = { move.goto_next_end, "@function.outer" },
				["]["] = { move.goto_next_end, "@class.outer" },
				["[m"] = { move.goto_previous_start, "@function.outer" },
				["[["] = { move.goto_previous_start, "@class.outer" },
				["[M"] = { move.goto_previous_end, "@function.outer" },
				["[]"] = { move.goto_previous_end, "@class.outer" },
			}) do
				vim.keymap.set({ "n", "x", "o" }, lhs, function()
					spec[1](spec[2], "textobjects")
				end, { desc = "Move to " .. spec[2] })
			end

			local swap = require("nvim-treesitter-textobjects.swap")
			vim.keymap.set("n", "<leader>a", function()
				swap.swap_next("@parameter.inner")
			end, { desc = "Swap parameter with next" })
			vim.keymap.set("n", "<leader>A", function()
				swap.swap_previous("@parameter.inner")
			end, { desc = "Swap parameter with previous" })
		end,
	},
}
