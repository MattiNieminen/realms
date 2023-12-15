local plugins = {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "markdown",
        "bicep",
        "yaml",
        "typescript",
        "sql"
      }
    }
  },
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
        "azure-pipelines-language-server",
        "bicep-lsp",
        "typescript-language-server"
      }
    }
  }
}

return plugins
