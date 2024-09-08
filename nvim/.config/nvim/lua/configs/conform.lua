local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettier" },
    html = { "prettier" },
    python = { "isort", "black" },
    c_sharp = { "csharpier" },
    javascript = { "prettier" },
    typescriptreact = { "prettier" },
    javascriptreact = { "prettier" },
    typescript = { "prettier" },
    json = { "prettier" },
    bash = { "beautysh" },
    php = { "php_cs_fixer" },
    blade = { "blade-formatter", "rustywind" },
  },

  formatters = {
    prettier = {
      command = "prettier",
      args = function()
        -- Allow Prettier to find the correct config file automatically
        return { "--stdin-filepath", vim.api.nvim_buf_get_name(0) }
      end,
      stdin = true,
    },

    black = {
      prepend_args = {
        "--fast",
        "--line-length",
        "80",
      },
    },
    isort = {
      prepend_args = {
        "--profile",
        "black",
      },
    },
    php_cs_fixer = {
      command = "php-cs-fixer",
      args = {
        "fix",
        "--rules=@PSR12",
        "--using-cache=no",
        "--no-interaction",
        "--quiet",
        "-",
      },
      stdin = true,
    },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 1000,
    lsp_fallback = true,
  },
}

require("conform").setup(options)
