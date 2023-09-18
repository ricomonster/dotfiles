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
        "eslint_d",
        "gopls",
      },
    },
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    ft = "go",
    opts = function()
      return require "custom.configs.null-ls"
    end,
  },
  {
    "f-person/git-blame.nvim",
    event = "VeryLazy"
  },
  {
    "m4xshen/hardtime.nvim",
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    event = "VeryLazy",
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    opts = {
      char = "",
      context_char = "⋅",
      show_current_context = true,
      show_current_context_start = true,
    }
  }
}

return plugins

