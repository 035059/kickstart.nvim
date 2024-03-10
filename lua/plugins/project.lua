return {
  "ahmedkhalf/project.nvim",
  config = function()
    require("project_nvim").setup {
      -- Enable telescope integration
      -- require('telescope').load_extension('projects'),
    }
  end
}
