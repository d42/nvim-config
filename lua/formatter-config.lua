local util = require "formatter.util"
require("formatter").setup {
  logging = true,
  log_level = vim.log.levels.WARN,
  filetype = {
    python = {
      require('formatter.filetypes.python').black,
      require('formatter.filetypes.python').isort,
    },
    html = {
      require('formatter.filetypes.html').prettier,
    },
    javascript = {
      require('formatter.filetypes.javascript').prettier,
    },
    css = {
      require('formatter.filetypes.css').prettier,
    },
    ["*"] = {
      require("formatter.filetypes.any").remove_trailing_whitespace
    }
  }
}
