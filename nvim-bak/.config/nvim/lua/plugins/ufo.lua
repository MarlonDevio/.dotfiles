return {
  "kevinhwang91/nvim-ufo",
  dependencies = { "kevinhwang91/promise-async" },
  lazy = false,
  config = function()
    local ufo = require "ufo"
    local o = vim.o
    local map = vim.keymap.set
    o.foldcolumn = "1"
    o.foldlevel = 99
    o.foldlevelstart = 99
    o.foldenable = true
    map("n", "zR", ufo.openAllFolds, { desc = "Ufo Open all folds" })
    map("n", "zM", ufo.closeAllFolds, { desc = "Ufo Close all folds" })

    ufo.setup {
      provider_selector = function(bufnr, filetype, buftype)
        return { "treesitter", "indent" }
      end,
    }
  end,
}
