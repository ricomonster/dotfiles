local plugins = {
  {
    "neovim/nvim-lspconfig",
    config = function ()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "typescript-language-server",
        "eslint_d"
      }
    }
  },
  {
    "f-person/git-blame.nvim",
    event = "VeryLazy"
  }
}

return plugins

