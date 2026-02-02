return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    event = "BufWritePre",
    dependencies = { "hrsh7th/nvim-cmp" },
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "mfussenegger/nvim-jdtls",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "javascript",
        "typescript",
        "cpp", -- ← add this
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = {
        enable = true,
      },
    },
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "clangd",
        "codelldb",
        "cpplint",
        "clang-format",
        "glsl_analyzer",
        "tailwindcss-language-server",
        "svelte-language-server",
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)
      require("mason-lspconfig").setup { ensure_installed = { "clangd" } }
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    opts = function(_, conf)
      table.insert(conf.sources, { name = "path" })
      table.insert(conf.sources, { name = "buffer", keyword_length = 5 })
      return conf
    end,
  },
  {
    "NeogitOrg/neogit",
    cmd = "Neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "sindrets/diffview.nvim",        -- optional - Diff integration

      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("neogit").setup {
        graph_style = "kitty",
        remember_settings = true,
        diffview = true
      }
    end,
  }
}
