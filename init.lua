-- vim.cmd('colorscheme onedark')
require("config")
require("plugins")

vim.api.nvim_command "colorscheme catppuccin"

-- vim.api.nvim_set_keymap('n', '<leader>b' ,":Telescope buffers<CR>", {})


vim.cmd([[
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree']
]])

local set = vim.opt
set.laststatus      = 3
require'nvim-tree'.setup {}
