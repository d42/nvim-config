-- disable netrw at the very start of your init.lua for nvim-tree.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- vim.cmd("let mapleader ,")
vim.cmd("nnoremap ; :")
-- vim.cmd('let mapleader = ","')
vim.g.mapleader = ' '
local set = vim.opt

set.clipboard = set.clipboard + "unnamedplus" --copy & paste
set.backspace       = 'indent,start,eol' -- make backspace behave like normal again

set.cmdheight       = 0

set.softtabstop     = 4
set.shiftwidth      = 4             -- spaces per tab (when shifting), when using the >> or << commands, shift lines by 4 spaces
set.tabstop         = 4             -- spaces per tab
set.laststatus      = 3

set.expandtab = true              -- Use spaces, not tabs, for autoindent/tab key.
set.shiftround = true

set.splitbelow      = true      -- open horizontal splits below current window
set.splitright      = true      -- open vertical splits to the right of the current window

vim.o.termguicolors   = true      -- Enable GUI colors for the terminal to get truecolor

set.diffopt = set.diffopt + "algorithm:patience"
set.diffopt= set.diffopt + "indent-heuristic"

set.ignorecase = true
set.hlsearch = true
set.smarttab = true
set.smartcase = true

set.wrap = false
set.number = true

set.cursorline = false
set.cursorcolumn = false
set.colorcolumn = "120"
set.scrolloff = 8

set.inccommand = "split"

set.mouse = "a"

set.showbreak = "↪"
set.breakindent = true
set.linebreak = true
set.lazyredraw = true

set.wildmenu = true
set.undofile = true

set.wildignore = set.wildignore + "*.o,*.obj,.git,*.pyc"
set.wildignore = set.wildignore + "eggs/**"
set.wildignore = set.wildignore + "*.egg-info/**"
set.wildignore = set.wildignore + "*.swp,*.bak"
set.wildignore = set.wildignore + "__pycache__"
set.wildignorecase = true

set.completeopt = 'menuone,noselect'

set.listchars = "tab:>-,eol:$,trail:-,precedes:<,extends:>"
set.list = true
-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })


vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})
