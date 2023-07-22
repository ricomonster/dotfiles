local telescope_setup, telescope = pcall(require, "telescope")
if (not telescope_setup) then return end

local status, builtin = pcall(require, 'telescope.builtin')
if (not status) then return end

-- Similar to VSCode's Ctrl/Cmd+P
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
-- Similar to VSCode's Ctrl/Cmd+Shift+F with UI
vim.keymap.set('n', '<leader>ps', builtin.live_grep, {})
-- Similar to VSCode's Ctrl/Cmd+Shift+F
vim.keymap.set('n', '<leader>pc', builtin.grep_string, {})

-- Telescope setup
telescope.setup({
    defaults = {
        file_ignore_patterns = {
            "node_modules"
        }
    }
});
