return {
  "nvim-neorg/neorg",
  dependencies = { "nvim-lua/plenary.nvim" },
  build = ":Neorg sync-parsers",
  -- tag = "*",
  lazy = true,   -- enable lazy load
  ft = "norg",   -- lazy load on file type
  cmd = "Neorg", -- lazy load on command
  config = function()
    require("neorg").setup {
      load = {
        ["core.defaults"] = {},  -- Loads default behaviour
        ["core.concealer"] = {}, -- Adds pretty icons to your documents
        ["core.dirman"] = {      -- Manages Neorg workspaces
          config = {
            workspaces = {
              personal = "~/notes/personal/",
              school = "~/notes/school/",
            },
          },
        },
      },
    }
    -- Concealer leved adjust when entering buffer
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
      pattern = { "*.norg" },
      command = "set conceallevel=3"
    })
  end,
}
