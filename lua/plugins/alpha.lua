return {
  'goolord/alpha-nvim',
  dependencies = {
    "MunifTanjim/nui.nvim",
    "MaximilianLloyd/ascii.nvim",
  },
  config = function()
    -- require'alpha'.setup(require'alpha.themes.dashboard'.config)
    require 'config/alpha-config'
  end
};
