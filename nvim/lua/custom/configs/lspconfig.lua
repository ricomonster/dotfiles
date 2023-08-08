local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

-- Eslint
lspconfig.eslint.setup({
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end
})


-- Typescript/Javascript Server
lspconfig.tsserver.setup{
  on_attach = on_attach,
  capabilities = capabilities
}

-- Golang
lspconfig.gopls.setup{
  on_attach = on_attach,
  capabilities = capabilities
}
