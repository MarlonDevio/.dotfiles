return {
  "VidocqH/lsp-lens.nvim",
  ft = {
    "lua",
    "typescript",
    "typescriptreact",
    "javascript",
    "javascriptreact",
    "php",
    "html",
    "css",
    "json",
    "yaml",
    "csharp",
  },
  config = function()
    require("lsp-lens").setup {
      sections = {
        git_authors = false,
        implements = true,
      },
    }
    -- Set custom highlights for LspCodeLens
    vim.api.nvim_set_hl(0, "LspLens", { fg = "#12989e", italic = true })
    vim.api.nvim_set_hl(0, "LspCodeLensSeparator", { fg = "#ffaa33", italic = true })
  end,
}
