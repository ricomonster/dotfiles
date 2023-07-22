local setup, nvimtree = pcall(require, "nvim-tree");
if not setup then
    return
end

-- Recommended settings
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

nvimtree.setup({
    actions = {
        open_file = {
            window_picker = {
                enable = false,
            }
        }
    }
})

-- Load Icons
require('lualine').setup({})

-- Keymaps
-- Toggle to show/hide nvimtree
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")

-- Focus on the active file in the nvimtree
vim.keymap.set("n", "<leader>kp", ":NvimTreeFindFile<CR>")

-- Focus on nvimtree
vim.keymap.set("n", "<leader>kf", ":NvimTreeFocus<CR>")
