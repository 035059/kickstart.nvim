return {
  -- File browser
  'stevearc/oil.nvim',
  opts = {},
  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("oil").setup({
      columns = {
        "icon",
        "size",
      },
      view_options = {
        is_always_hidden = function(name, _)
          return name == ".git"
              or name == "lazy-lock.json"
              or name == "."
              or name == ".."
              or string.match(name, "cache")
        end
      }
    })
  end,
}
