return {
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
      "Saghen/blink.cmp", -- Making sure blink.cmp is a dependency
    },
    config = function()
      -- Base Mason setup
      require("mason").setup()

      -- Define server configurations
      local servers = {
        clangd = {},
        gopls = {},
        pyright = {},
        rust_analyzer = {},
        html = { filetypes = { "html", "twig", "hbs" } },
        lua_ls = {
          Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
            diagnostics = { disable = { "missing-fields" } },
          },
        },
      }

      -- Setup mason-lspconfig
      require("mason-lspconfig").setup({
        ensure_installed = vim.tbl_keys(servers),
      })

      -- Get blink.cmp capabilities
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      -- Setup each server directly without using setup_handlers
      local lspconfig = require("lspconfig")
      for server_name, server_config in pairs(servers) do
        local config = {
          capabilities = capabilities,
          -- on_attach is commented out as it was in your code
          -- on_attach = on_attach,
          filetypes = (server_config.filetypes or {}),
        }

        -- Apply settings if they exist
        if server_config.Lua then
          config.settings = { Lua = server_config.Lua }
        else
          config.settings = server_config
        end

        lspconfig[server_name].setup(config)
      end
    end,
  }
  ,
}
