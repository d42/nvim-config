require('telescope').setup{
    defaults = {
        file_ignore_patterns = {"%.sqlite", "%.db", "__pycache__", "%.tar.gz", "%.whl", "vendor"},
    }
}

local opts = {noremap=true}

vim.keymap.set('n', '<leader>b', function() require('telescope.builtin').buffers({sort_lastused=true}) end, {})
vim.api.nvim_set_keymap('n', '<leader>f' ,":Telescope find_files<CR>", {})
pcall(require('telescope').load_extension, 'fzf')


vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', function() require('telescope.builtin').buffers({sort_lastused=true}) end, { desc = '[ ] Find existing buffers'})
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer]' })

vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
