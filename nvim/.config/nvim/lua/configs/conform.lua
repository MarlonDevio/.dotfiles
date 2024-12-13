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
    php = { "php_cs_fixer", "phpcbf" },
    blade = { "blade-formatter", "prettier" },
    latex = { "latexindent" },
  },

  formatters = {
    prettier = {
      command = "/Users/marlon/.local/share/nvim/mason/bin/prettier",
      args = function()
        -- Allow Prettier to find the correct config file automatically
        return { "--stdin-filepath", vim.api.nvim_buf_get_name(0), "--config-precedence", "prefer-file", "--stdin" }
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
    phpcbf = {
      command = "phpcbf", -- Command to use PHPCBF
      args = {
        "--standard=PSR2", -- You can use other standards like PSR12 or custom ones
        "-",
      },
      stdin = true, -- Use stdin for content formatting
    },
    blade_formatter = {
      name = "blade-formatter",
      command = "/Users/marlon/.local/share/nvim/mason/bin/blade-formatter",
      args = {
        "--tab-width",
        "--use-spaces",
        "--align-attributes",
        "--align-text",
        "--compress-html",
        "--format-php",
        "--format-xml",
        "--format-yaml",
        "--line-breaks",
        "--line-trimming",
        "--replace",
        "--sort-attributes",
        "--trailing-blank-lines",
        "--trailing-spaces",
        "--wrap-html",
        "--wrap-php",
        "--wrap-text",
        "--wrap-xml",
        "--wrap-yaml",
        "--wrap-yml",
      },
      stdin = true,
      stream = "stdout",
    },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 2000,
    lsp_fallback = true,
  },
}

require("conform").setup(options)
