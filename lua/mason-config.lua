require("mason").setup()
require("mason-nvim-dap").setup({

    handlers = {
        function(config)
          -- all sources with no handler get passed here

          -- Keep original functionality
          require('mason-nvim-dap').default_setup(config)
        end,
        python = function(config)
          local home = os.getenv("HOME")
          local mason_packages = "/.local/share/nvim/mason/packages"

          local venv_path = '/usr/bin/python3'
          local handle = io.popen("/home/d42/.local/bin/poetry-path-generator 2> /tmp/guwno")
          local result = handle:read("*l")
          if result then
            venv_path = result .. "/bin/python3"
          end

          config.adapters = {
              type = "executable",
              command = venv_path,
              args = {
                  "-m",
                  "debugpy.adapter",
              },
          }
            require('mason-nvim-dap').default_setup(config) -- don't forget this!
        end,
    },


})
-- require("mason-nvim-dap").setup_handlers()
require("mason-null-ls").setup()
require("null-ls").setup()

require("mason-lspconfig").setup()
require('mason-lspconfig').setup_handlers {
  function(server_name)
    require("lspconfig")[server_name].setup {}
  end,

  ["pyright"] = function ()

    local venv_path = '/usr/bin/python3'
    local handle = io.popen("/home/d42/.local/bin/poetry-path-generator 2> /tmp/guwno")
    local result = handle:read("*l")
    if result then
      venv_path = result .. "/bin/python3"
    end
    handle:close()
    require('lspconfig')['pyright'].setup {
      settings = {
        python = {
          pythonPath = venv_path
        }
      }
    }
  end
}
