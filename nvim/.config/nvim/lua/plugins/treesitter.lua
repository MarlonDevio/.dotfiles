local treesitter = {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    {
      "JoosepAlviste/nvim-ts-context-commentstring",
      opts = {
        custom_calculation = function(_, language_tree)
          if vim.bo.filetype == "blade" and language_tree._lang ~= "javascript" and language_tree._lang ~= "php" then
            return "{{-- %s --}}"
          end
        end,
      },
    },
    "nvim-treesitter/nvim-treesitter-textobjects",
    "chrisgrieser/nvim-various-textobjs",
  },
  opts = {
    ensure_installed = {
      "html",
      "bash",
      "php",
      "javascript",
      "css",
      "typescript",
      "tsx",
      "c",
      "cmake",
      "regex",
      -- "cpp",
      "fish",
      -- "go",
      -- "gomod",
      -- "gosum",
      -- "gotmpl",
      -- "gowork",
      "lua",
      "luadoc",
      -- "make",
      "markdown",
      "markdown_inline",
      "printf",
      "python",
      "toml",
      "vim",
      "vimdoc",
      "yaml",
      "c_sharp",
      "latex",
    },
    auto_install = true,
    highlight = {
      enable = true,
      use_languagetree = true,
    },

    indent = { enable = true },
  },
  config = function(_, opts)
    ---@class ParserInfo
    local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
    parser_config.blade = {
      install_info = {
        url = "https://github.com/EmranMR/tree-sitter-blade",
        files = {
          "src/parser.c",
          -- 'src/scanner.cc',
        },
        branch = "main",
      },
      filetype = "blade",
    }

    require("nvim-treesitter.configs").setup(opts)
  end,
}

return treesitter
