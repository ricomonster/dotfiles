return {
  {
    'nvim-tree/nvim-tree.lua',
    config = function()
      vim.keymap.set('n', '<leader>e', ':NvimTreeFocus<CR>', { silent = true, desc = 'Focus nvimtr[e]e' })
      vim.keymap.set('n', '<leader>et', ':NvimTreeToggle<CR>', { silent = true, desc = 'Toggl[e] nvim[t]ree' })
      require('nvim-tree').setup {
        filters = {
          dotfiles = false,
        },
        git = {
          enable = true,
          ignore = false,
          timeout = 500,
        },
      }
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
