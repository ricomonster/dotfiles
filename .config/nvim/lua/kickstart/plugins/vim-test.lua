return {
  {
    'vim-test/vim-test',
    dependencies = {
      'preservim/vimux',
    },
    config = function()
      vim.keymap.set('n', '<leader>t', ':TestNearest<CR>', { desc = '[T]est nearest' })
      vim.keymap.set('n', '<leader>tf', ':TestFile<CR>', { desc = 'Runs all [t]ests in the current [f]ile' })
      vim.keymap.set('n', '<leader>ts', ':TestSuite<CR>', { desc = 'Runs the whole [t]est [s]uite' })
      vim.keymap.set('n', '<leader>tl', ':TestLast<CR>', { desc = 'Runs [t]he [l]ast test.' })
      vim.keymap.set('n', '<leader>tg', ':TestVisit<CR>', { desc = 'Runs [t]he previously [v]isited test file' })

      vim.cmd "let test#strategy = 'vimux'"
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
