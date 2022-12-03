local nvim_lsp = require('lspconfig')
local lsp_installer = require("nvim-lsp-installer")
local cmp = require('cmp')
local navic = require("nvim-navic")
-- local coq = require("coq")

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  if client.server_capabilities.documentSymbolProvider then
      navic.attach(client, bufnr)
  end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  if client.name == "pylsp" then
      -- print(vim.inspect(client.name))

      client.resolved_capabilities.rename = false
    end


  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>Telescope lsp_code_actions()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>Telescope lsp_references<CR>', opts)
  -- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>Telescope diagnostics bufnr=0<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)


  buf_set_keymap('n', '<leader>f', '<cmd>Telescope find_files<CR>', opts)
  buf_set_keymap('n', '<leader>F', '<cmd>Telescope grep_string<CR>', opts)
  buf_set_keymap('n', '<leader>b', '<cmd>Telescope buffers<CR>', opts)

  require "lsp_signature".on_attach()

end


local venv_path = nil
if os.getenv("VIRTUAL_ENV") then
  venv_path = os.getenv("VIRTUAL_ENV") .. "/bin/python"
  -- print(venv_path)
end

-- print(os.getenv("VIRTUAL_ENV"))


-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
  local opts = {
    on_attach=on_attach,
  }
  if server.name == 'sumneko_lua' then
    opts.settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
  }}

  end

  if server.name == 'pyright' then
    if (venv_path ~= nil) then
      opts.settings = {
        python = {
          pythonPath = venv_path
        }
      }
    end
  end

  local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
  if server.name == 'pylsp' then
    if( venv_path ~= nil) then
      opts.settings = {
        pylsp = {
          plugins = {
            pylsp_mypy = {
              enabled = true,
              overrides = {"--python-executable", venv_path .. "/bin/python", true},
          },
          flake8 = {
            executable = "flake518",
          },
        }
      }
    }
    end
  end
  opts.capabilities = capabilities
  server:setup(
    opts
  )
end
)
-- vim.cmd("COQnow --shut-up")S
--
--
  cmp.setup({
    view = {
      entries = "native",
    },
    completion = {
      autocomplete = true,
    },
    sorting = {
      comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            require "cmp-under-comparator".under,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
      },
    },
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    mapping = {
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    },
    sources = {
      { name = 'nvim_lsp' },
      -- { name = 'vsnip' }, -- For vsnip users.
      { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    {
      name = 'buffer',
      -- Correct:
      option = {
        keyword_pattern = [[\k\+]],
      }
    }
    }
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })
local function prequire(...)
local status, lib = pcall(require, ...)
if (status) then return lib end
    return nil
end

local luasnip = prequire('luasnip')
local cmp = prequire("cmp")

local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

_G.tab_complete = function()
    local types = require('cmp.types')
    if cmp and cmp.visible() then
      -- print("gnuj")
        cmp.select_next_item({ behavior = types.cmp.SelectBehavior.Select })
    elseif luasnip and luasnip.expand_or_jumpable() then
        return t("<Plug>luasnip-expand-or-jump")
    elseif check_back_space() then
        return t "<Tab>"
    else
        cmp.complete()
    end
    return ""
end
_G.s_tab_complete = function()
    local types = require('cmp.types')
    if cmp and cmp.visible() then
        cmp.select_prev_item({ behavior = types.cmp.SelectBehavior.Select })
    elseif luasnip and luasnip.jumpable(-1) then
        return t("<Plug>luasnip-jump-prev")
    else
        return t "<S-Tab>"
    end
    return ""
end



vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<C-E>", "<Plug>luasnip-next-choice", {})
vim.api.nvim_set_keymap("s", "<C-E>", "<Plug>luasnip-next-choice", {})

require('luasnip.loaders.from_vscode').lazy_load()

require "lsp_signature".on_attach({
    bind = true,
    floating_window = true,
    floating_window_above_cur_line = true,
    fix_pos = false,
    hint_enable = true,
    hint_prefix = " ",
    hint_scheme = "String",
    use_lspsaga = false,
    hi_parameter = "ModeMsg",
    max_height = 12,
    max_width = 120,
    -- transparency = 80,
    handler_opts = { border = "none" },
    trigger_on_newline = false,
    debug = false,
    padding = '',
    -- shadow_blend = 36,
    -- shadow_guibg = 'Black',
    timer_interval = 200,
    toggle_key = '<M-f>',
})

require "lspconfig".efm.setup {
    init_options = {documentFormatting = true},
    settings = {
        rootMarkers = {".git/"},
        languages = {
            lua = {
                {formatCommand = "lua-format -i", formatStdin = true}
            },
            python = {
                {formatCommand = "black --quiet -SC -", formatStdin = true},
                {formatCommand = "isort --quiet -", formatStdin = true}
            }
        }
    }
}
