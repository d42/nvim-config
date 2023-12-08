local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<F5>' ,":lua require'dap'.continue()<CR>", opts)
vim.api.nvim_set_keymap('n', '<F10>', ":lua require'dap'.step_over()<CR>", opts)
vim.api.nvim_set_keymap('n', '<F11>', ":lua require'dap'.step_into()<CR>", opts)
vim.api.nvim_set_keymap('n', '<F12>', ":lua require'dap'.step_out()<CR>", opts)
vim.api.nvim_set_keymap('n', '<leader>p', ":lua require'dap'.toggle_breakpoint()<CR>", opts)
vim.api.nvim_set_keymap('n', '<leader>B', ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", opts)
vim.api.nvim_set_keymap('n', '<leader>lp', ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>", opts)
vim.api.nvim_set_keymap('n', '<leader>dr', ":lua require'dap'.repl.open()<CR>", opts)
vim.api.nvim_set_keymap('n', '<leader>dl', ":lua require'dap'.run_last()<CR>", opts)

vim.api.nvim_set_keymap('n', '<leader>n' ,":NvimTreeToggle<CR>", {})


local nmap = function(keys, func, desc)
  if desc then
    desc = 'LSP: ' .. desc
  end

  vim.keymap.set('n', keys, func, { desc = desc })
end

nmap('<space>rn', vim.lsp.buf.rename, '[R]e[n]ame')
nmap('<space>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
-- nmap('<leader>q', function() require('telescope.builtin').diagnostics({layout_strategy='vertical', preview=true, wrap_results=true}) end, 'Diagnostics')
nmap('<leader>q', function() require("trouble").open('document_diagnostics') end, 'Diagnostics')
nmap('<leader>Q', function() require("trouble").open('workspace_diagnostics') end, 'Diagnostics')
nmap('gD', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
nmap('gi', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
nmap('<space>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
nmap('<space>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
-- nmap('<space>e', vim.lsp.diagnostic.show_line_diagnostic, "Lin[E] Diagnostics")

nmap('<leader>f', require('telescope.builtin').find_files, "[F]ind files")
nmap('<leader>g', require('telescope.builtin').grep_string, "[F]ind Strings")
nmap('<leader>b', require('telescope.builtin').buffers, "[B]uffers")
-- nmap('<leader>t', require('telescope.builtin').find_files, "[F]ind files")

-- See `:help K` for why this keymap
nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

-- Lesser used LSP functionality
nmap('<space>D', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
nmap('<leader>wl', function()
  -- print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, '[W]orkspace [L]ist Folders')
