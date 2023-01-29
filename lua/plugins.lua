-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
  vim.cmd [[packadd packer.nvim]]
end

require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'mechatroner/rainbow_csv' -- Rainbow CSV - Vim plugin: Highlight columns in CSV and TSV files and run queries in SQL-like language
    use 'numToStr/Comment.nvim'
    use 'lukas-reineke/indent-blankline.nvim' -- This plugin adds indentation guides to all lines (including empty lines).
    use 'lambdalisue/suda.vim'
    use 'folke/which-key.nvim'
    use 'mhartington/formatter.nvim'
    use {'glepnir/template.nvim'}
    use {
        "catppuccin/nvim",
        as = "catppuccin",
        config = function()
            vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
            require("catppuccin").setup({
              integrations = {
                gitsigns = true,
                telescope = true,
                native_lsp = {
                            enabled = true,
                            virtual_text = {
                                errors = { "italic" },
                                hints = { "italic" },
                                warnings = { "italic" },
                                information = { "italic" },
                            },
                            underlines = {
                                errors = { "underline" },
                                hints = { "underline" },
                                warnings = { "underline" },
                                information = { "underline" },
                            },
                },
            }})
            vim.api.nvim_command "colorscheme catppuccin"
        end
    }



    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'


    use 'liuchengxu/vista.vim'

    use {
      'kyazdani42/nvim-tree.lua',
      requires = {
        'kyazdani42/nvim-web-devicons', -- optional, for file icon
      },
      config = function() require'nvim-tree'.setup {} end
    }

    -- Treesitter
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use 'nvim-treesitter/nvim-treesitter-textobjects'                               -- Additional textobjects for treesitter
    use {"p00f/nvim-ts-rainbow"}

    -- lsp
      use { -- LSP Configuration & Plugins
      'neovim/nvim-lspconfig',
      requires = {
        -- Automatically install LSPs to stdpath for neovim
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',

        -- Useful status updates for LSP
        'j-hui/fidget.nvim',

        -- Additional lua configuration, makes nvim stuff amazing
        'folke/neodev.nvim',
      },
    }
  --
    use 'honza/vim-snippets'

    use {
        "SmiteshP/nvim-navic",
        requires = "neovim/nvim-lspconfig"
    }

    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use { -- Autocompletion
      'hrsh7th/nvim-cmp',
      requires = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
    }
    use "lukas-reineke/cmp-under-comparator"
    use "ray-x/lsp_signature.nvim"
    use {'ojroques/vim-oscyank', branch='main'}
    -- use "haringsrob/nvim_context_vt"
    use 'saadparwaiz1/cmp_luasnip'
    use {
      "folke/trouble.nvim",
      requires = "nvim-tree/nvim-web-devicons",
      config = function()
        require("trouble").setup {}
      end
    }


    -- DAB YOLO
    use 'mfussenegger/nvim-dap'
    use 'mfussenegger/nvim-dap-python'
    use 'leoluz/nvim-dap-go'
    use 'rcarriga/nvim-dap-ui'
    use 'theHamsta/nvim-dap-virtual-text'
    use 'nvim-telescope/telescope-dap.nvim'
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable "make" == 1 }

    -- Snippets
    use {'L3MON4D3/LuaSnip', requires = { 'saadparwaiz1/cmp_luasnip' } } -- Snippet Engine and Snippet Expansion
    use "rafamadriz/friendly-snippets"

    -- use "ms-jpq/coq_nvim"
    --
    use 'simrat39/symbols-outline.nvim'
    -- use 'fannheyward/telescope-coc.nvim'

    use 'tpope/vim-fugitive'
    use 'tpope/vim-rhubarb'                                                         -- Fugitive-companion to interact with github
    -- use 'mhinz/vim-signify'
    use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }       -- Add git related info in the signs columns and popups

    use 'summivox/vim-nfo'
    use 'leafgarland/typescript-vim'
    use 'drewtempelmeyer/palenight.vim'
    use "ray-x/aurora"
    use 'nvim-lualine/lualine.nvim'                                                 -- Fancier statusline



    use 'chriskempson/tomorrow-theme'
    use 'sheerun/vim-polyglot'
    use 'https://gitlab.com/yorickpeterse/happy_hacking.vim.git'
    use { "beauwilliams/focus.nvim"}
    -- pane resizing boi

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if is_bootstrap then
    require('packer').sync()
  end
end)

if is_bootstrap then
  print '=================================='
  print '    Plugins are being installed'
  print '    Wait until Packer completes,'
  print '       then restart nvim'
  print '=================================='
  return
end

-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  command = 'source <afile> | silent! LspStop | silent! LspStart | PackerCompile',
  group = packer_group,
  pattern = vim.fn.expand '$MYVIMRC',
})

require('template-config')
require('nvim-tree-config')
require('formatter-config')
require('treesitter-config')
require('indent-blankline-config')
require('lspconfig-config')
require('symbols-outline-config')
require('telescope-config')
require("focus-config")
require('dap-config')
require('comment-config')
require('gitsigns-config')
require('lualine-config')
