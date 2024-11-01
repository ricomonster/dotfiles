return {
  {
    'kevinhwang91/nvim-ufo',
    dependencies = { 'kevinhwang91/promise-async' },
    event = 'BufRead',
    keys = {
      {
        'zR',
        function()
          require('ufo').openAllFolds()
        end,
      },
      {
        'zM',
        function()
          -- require('ufo').closeAllFolds()
          require('ufo').closeAllFolds()
        end,
      },
      {
        'K',
        function()
          local winid = require('ufo').peekFoldedLinesUnderCursor()
          if not winid then
            vim.lsp.buf.hover()
          end
        end,
      },
    },
    config = function()
      vim.o.foldcolumn = '1'
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
      require('ufo').setup {
        -- close_fold_kinds_for_ft = {
        --   default = { 'imports' },
        -- },
      }
    end,
  },
}

-- vim: ts=2 sts=2 sw=2 et
