local plugins = {

  -- {
  --   "hiphish/rainbow-delimiters.nvim",
  --   lazy = false,
  --   config = function()
  --     -- Load the rainbow-delimiters plugin
  --     local rainbow_delimiters = require "rainbow-delimiters"
  --
  --     -- Set up the configuration for rainbow-delimiters
  --     vim.g.rainbow_delimiters = {
  --       strategy = {
  --         [""] = rainbow_delimiters.strategy["global"],
  --         vim = rainbow_delimiters.strategy["local"],
  --       },
  --       query = {
  --         [""] = "rainbow-parens",
  --       },
  --       priority = {
  --         [""] = 110,
  --       },
  --       highlight = {
  --         "RainbowDelimiterRed",
  --         "RainbowDelimiterYellow",
  --         "RainbowDelimiterBlue",
  --         "RainbowDelimiterOrange",
  --         "RainbowDelimiterGreen",
  --         "RainbowDelimiterViolet",
  --         "RainbowDelimiterCyan",
  --       },
  --       blacklist = { "html" },
  --     }
  --   end,
  -- },
  {
    "luckasRanarison/tailwind-tools.nvim",
    name = "tailwind-tools",
    build = ":UpdateRemotePlugins",
    ft = { "js, jsx, ts,tsx, html, css" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim", -- optional
      "neovim/nvim-lspconfig", -- optional
    },

    opts = function()
      local config = require("tailwind-tools").setup {}
      return config
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "luckasRanarison/tailwind-tools.nvim",
      "onsails/lspkind-nvim",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",

      {
        "L3MON4D3/LuaSnip",
        build = (function()
          if vim.fn.has "win32" == 1 or vim.fn.executable "make" == 0 then
            return
          end
          return "make install_jsregexp"
        end)(),
        dependencies = {
          {
            "rafamadriz/friendly-snippets",
            config = function()
              require("luasnip.loaders.from_vscode").lazy_load()
            end,
          },
        },
      },
    },
    opts = function()
      local conf = require "nvchad.configs.cmp"
      local lspkind = require "lspkind"
      local tailwind_tools = require "tailwind-tools.cmp"
      local cmp = require "cmp"

      conf.formatting = {
        format = lspkind.cmp_format {
          mode = "symbol_text",
          maxwidth = 50,
          ellipsis_char = "...",
          before = function(entry, vim_item)
            -- First apply tailwind-tools formatting
            vim_item = tailwind_tools.lspkind_format(entry, vim_item)

            -- Then apply any other custom formatting you want
            -- For example, you can add the source name to the menu
            vim_item.menu = ({
              buffer = "[Buffer]",
              nvim_lsp = "[LSP]",
              luasnip = "[LuaSnip]",
              nvim_lua = "[Lua]",
              latex_symbols = "[LaTeX]",
            })[entry.source.name]

            return vim_item
          end,
        },
      }

      return conf
    end,
  },

  -- spectre
  {
    "nvim-pack/nvim-spectre",

    opts = function()
      local spectre = require "spectre"
      local config = spectre.setup()
      return config
    end,
  },

  -- custom/plugins.lua
  -- {
  --   "pieces-app/plugin_neo_vim",
  --   lazy = "VeryLazy",
  --   dependencies = {
  --     "kyazdani42/nvim-web-devicons",
  --     "MunifTanjim/nui.nvim",
  --     "hrsh7th/nvim-cmp",
  --   },
  --   init = function()
  --     require("pieces.config").host = "http://localhost:1000"
  --   end,
  -- },
  { "dstein64/vim-startuptime", lazy = false },
}

return plugins
