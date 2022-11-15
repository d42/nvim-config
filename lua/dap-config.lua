local opts = { noremap=true, silent=true }
-- local opts = {}
vim.api.nvim_set_keymap('n', '<F5>' ,":lua require'dap'.continue()<CR>", opts)
vim.api.nvim_set_keymap('n', '<F10>', ":lua require'dap'.step_over()<CR>", opts)
vim.api.nvim_set_keymap('n', '<F11>', ":lua require'dap'.step_into()<CR>", opts)
vim.api.nvim_set_keymap('n', '<F12>', ":lua require'dap'.step_out()<CR>", opts)
vim.api.nvim_set_keymap('n', '<leader>p', ":lua require'dap'.toggle_breakpoint()<CR>", opts)
vim.api.nvim_set_keymap('n', '<leader>B', ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", opts)
vim.api.nvim_set_keymap('n', '<leader>lp', ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>", opts)
vim.api.nvim_set_keymap('n', '<leader>dr', ":lua require'dap'.repl.open()<CR>", opts)
vim.api.nvim_set_keymap('n', '<leader>dl', ":lua require'dap'.run_last()<CR>", opts)


 require('dap-go').setup({
   on_attach = function()
   end
 })

local venv_path = "/usr/bin/python"
if os.getenv("VIRTUAL_ENV") then
  venv_path = os.getenv("VIRTUAL_ENV") .. "/bin/python"
end
require('dap-python').setup(venv_path)
require("nvim-dap-virtual-text").setup()

require("dapui").setup({
  icons = { expanded = "▾", collapsed = "▸" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  layouts = {
    {
      elements = {
        'scopes',
        'breakpoints',
        'stacks',
        'watches',
      },
      size = 40,
      position = 'left',
    },
    {
      elements = {
        'repl',
        'console',
      },
      size = 10,
      position = 'bottom',
    },
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    border = "single", -- Border style. Can be "single", "double" or "rounded"
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
})
