local navic = require("nvim-navic")

navic.setup {
    lsp = { auto_attach = true },

}

require('lualine').setup {
  tabline = {
      lualine_c = {
            {
              function()
                  return navic.get_location()
              end,
              cond = function()
                  return navic.is_available()
              end
            },
        },
  },

  sections = {
    lualine_c = {
      {'filename', path = 1},
        -- show_filename_only=false,
    }
  },
  options = {
    icons_enabled = true,
    theme = 'catppuccin',
    component_separators = '|',
    section_separators = '',
  },
}
