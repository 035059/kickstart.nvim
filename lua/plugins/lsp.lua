return {
	{
		"mason-org/mason.nvim",
		opts = {},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		opts = {
			ensure_installed = {
				"lua_ls",
				"pyright",
				"rust_analyzer",
				"texlab",
			},
		},
		config = function(_, opts)
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspKeymaps", { clear = true }),
				callback = function(ev)
					local function map(lhs, rhs, desc)
						vim.keymap.set("n", lhs, rhs, { buffer = ev.buf, desc = desc })
					end
					map("gd", vim.lsp.buf.definition, "Go to definition")
					map("gD", vim.lsp.buf.declaration, "Go to declaration")
					map("gi", vim.lsp.buf.implementation, "Go to implementation")
					map("gr", vim.lsp.buf.references, "Find references")
					map("<C-k>", vim.lsp.buf.signature_help, "Signature help")
					map("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
					map("<leader>ca", vim.lsp.buf.code_action, "Code action")
					map("<leader>f", function()
						vim.lsp.buf.format({ async = true })
					end, "Format buffer")
				end,
			})

			require("mason-lspconfig").setup(opts)
		end,
	},
	{
		"neovim/nvim-lspconfig",
	},
}
