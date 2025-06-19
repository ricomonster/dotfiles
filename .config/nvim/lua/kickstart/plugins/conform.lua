return {
  { -- Autoformat
    'stevearc/conform.nvim',
    lazy = false,
    -- opts = {
    --   notify_on_error = false,
    --   format_on_save = {
    --     timeout_ms = 500,
    --     lsp_fallback = true,
    --   },
    --   formatters_by_ft = {
    --     lua = { 'stylua' },
    --     -- Conform can also run multiple formatters sequentially
    --     -- python = { "isort", "black" },
    --     --
    --     -- You can use a sub-list to tell conform to run *until* a formatter
    --     -- is found.
    --     -- javascript = { 'eslint_d' },
    --     -- typescript = { 'eslint_d' },
    --     -- svelte = { 'eslint_d' },
    --     go = { 'goimports-reviser', 'gofumpt' },
    --   },
    -- },
    config = function()
      require('conform').setup {
        format_on_save = {
          timeout_ms = 500,
          lsp_format = 'fallback',
        },
        notify_no_formatters = true,
        notify_on_error = true,
        formatters_by_ft = {
          lua = { 'stylua' },
          json = { 'jsonlint' },
          -- javascript = { 'prettierd' },
          -- typescript = { 'prettierd' },
          -- svelte = { 'prettierd' },
          go = { 'goimports-reviser', 'gofumpt' },
        },
      }

      -- vim.api.nvim_create_autocmd('BufWritePre', {
      --   group = vim.api.nvim_create_augroup('EslintFixAll', { clear = true }),
      --   pattern = { '*.tsx', '*.ts', '*.jsx', '*.js', '*.svelte' },
      --   command = 'silent! EslintFixAll',
      -- })
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
