-- Autoformat
return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  config = function(_, opts)
    require('conform').setup(opts)

    -- Pre-warm eslint_d so it's ready before first save
    vim.api.nvim_create_autocmd('VimEnter', {
      callback = function()
        vim.fn.jobstart('eslint_d status || eslint_d start', { detach = true })
      end,
    })
  end,
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      local disable_filetypes = { c = true, cpp = true }
      if disable_filetypes[vim.bo[bufnr].filetype] then
        return nil
      else
        return {
          lsp_format = 'never',
          timeout_ms = 5000,
        }
      end
    end,
    formatters_by_ft = {
      lua = { 'stylua' },
      javascript = { 'eslint_d', stop_after_first = true },
      typescript = { 'eslint_d', stop_after_first = true },
      svelte = { 'eslint_d', stop_after_first = true },
      go = { 'goimports-reviser', 'gofumpt' },
      nix = { 'alejandra' },
    },
  },
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
