return {

  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-lspconfig" },
    config = function()
      require "configs.mason-lspconfig"
    end,
  },

  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require "configs.lint"
    end,
  },

  {
    "rshkarin/mason-nvim-lint",
    event = "VeryLazy",
    dependencies = { "nvim-lint" },
    config = function()
      require "configs.mason-lint"
    end,
  },

  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    config = function()
      require "configs.conform"
    end,
  },

  {
    "zapling/mason-conform.nvim",
    event = "VeryLazy",
    dependencies = { "conform.nvim" },
    config = function()
      require "configs.mason-conform"
    end,
  },
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
  },
  {
    "wakatime/vim-wakatime",
    lazy = false,
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },
  {
    "folke/trouble.nvim",
    lazy = true,
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>aa",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Trouble Diagnostics (Trouble)",
      },
      {
        "<leader>aA",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Trouble Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>as",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Trouble Symbols (Trouble)",
      },
      {
        "<leader>al",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "Trouble LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>aL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Trouble Location List (Trouble)",
      },
      {
        "<leader>aQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Trouble Quickfix List (Trouble)",
      },
    },
  },
  { "tpope/vim-repeat", event = "VeryLazy" },
}
