local plugins = {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "markdown",
        "clojure"
      }
    }
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "clojure-lsp"
      }
    }
  },
  {
    "Olical/conjure",
    ft = { "clojure" },
    config = function(_, opts)
      require("conjure.main").main()
      require("conjure.mapping")["on-filetype"]()
    end,
    init = function()
      vim.g["conjure#mapping#prefix"] = ","
    end
  },
  {
    "julienvincent/nvim-paredit",
    ft = { "clojure" },
    config = function()
      require("nvim-paredit").setup({
        indent = {
          enabled = true
        }
      })
    end
  },
  -- NvChad defaults are too aggressive for Clojure.
  -- It would insert '(' after autocompleting functions.
  -- It would not insert close pair if next character is close pair.
  {
    "windwp/nvim-autopairs",
    opts = {
      enable_check_bracket_line = false
    },
    config = function(_, opts)
      require("nvim-autopairs").setup(opts)
    end
  }
}

return plugins
