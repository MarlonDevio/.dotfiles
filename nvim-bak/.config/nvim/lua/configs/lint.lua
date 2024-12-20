local lint = require "lint"

lint.linters_by_ft = {
  lua = { "luacheck" },
  python = { "flake8" },
  javascriptreact = { "eslint_d" },
  javascript = { "eslint_d" },
  typescript = { "eslint_d" },
  typescriptreact = { "eslint_d" },
  bash = { "shellcheck" },
  latex = { "vale" },
}

lint.linters.luacheck.args = {
  "--globals",
  "love",
  "vim",
  "--formatter",
  "plain",
  "--codes",
  "--ranges",
  "-",
}

-- ESLint args configuration (for JavaScript/TypeScript files)
lint.linters.eslint_d = {
  command = "eslint_d", -- Use eslint_d as the linter
  args = function()
    -- Check if an ESLint config file exists in the current working directory
    local config_exists = vim.fn.glob(vim.fn.getcwd() .. "/.eslintrc*") ~= ""

    -- If config exists, don't add --no-eslintrc, otherwise add it to use default rules
    if config_exists then
      return { "--stdin", "--stdin-filename", vim.api.nvim_buf_get_name(0) }
    else
      return { "--stdin", "--stdin-filename", vim.api.nvim_buf_get_name(0), "--no-eslintrc", "--env", "es6" }
    end
  end,
}

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
  callback = function()
    lint.try_lint()
  end,
})
