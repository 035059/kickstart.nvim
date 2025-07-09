return {
	-- Mason for managing LSP servers, DAP servers, linters, and formatters
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	-- Integration with lspconfig
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		config = function()
			-- Configure LSP capabilities to work with completion
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities =
				vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities({}, false))

			-- Setup common on_attach for all servers
			local on_attach = function(client, bufnr)
				-- Enable completion triggered by <c-x><c-o>
				vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
				-- LSP key mappings
				local opts = { noremap = true, silent = true, buffer = bufnr }
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
				vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
				vim.keymap.set("n", "<leader>f", function()
					vim.lsp.buf.format({ async = true })
				end, opts)
			end

			require("mason-lspconfig").setup({
				-- Automatically install LSP servers
				automatic_installation = true,
				-- Specify servers you want to use
				ensure_installed = {
					"lua_ls",
					"pyright",
					"rust_analyzer",
				},
				-- Configure handlers for each server
				handlers = {
					function(server_name)
						require("lspconfig")[server_name].setup({
							on_attach = on_attach,
							capabilities = capabilities,
						})
					end,
					-- Special configuration for lua_ls
					["lua_ls"] = function()
						require("lspconfig").lua_ls.setup({
							on_attach = on_attach,
							capabilities = capabilities,
							filetypes = { "lua" },
							settings = {
								Lua = {
									diagnostics = {
										globals = { "vim" }, -- Recognize 'vim' global
									},
									workspace = {
										-- Only include Neovim's Lua runtime, not all files
										library = {
											vim.env.VIMRUNTIME .. "/lua",
											vim.env.VIMRUNTIME .. "/lua/vim/lsp",
											"${3rd}/luv/library",
										},
										checkThirdParty = false,
									},
									telemetry = { enable = false },
								},
							},
						})
					end,
				},
			})
		end,
	},
	-- Core LSP configuration plugin
	{
		"neovim/nvim-lspconfig",
	},
}
