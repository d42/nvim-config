local navic = require("nvim-navic")

require('lualine').setup {
  tabline = {
      lualine_c = {
          { navic.get_location, cond = navic.is_available },
      }
  },
  options = {
    icons_enabled = false,
    theme = 'catppuccin',
    component_separators = '|',
    section_separators = '',
  },
}
