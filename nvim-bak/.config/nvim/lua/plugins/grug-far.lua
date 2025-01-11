return {
  "MagicDuck/grug-far.nvim",
  keys = { "n", "<leader>gfw" },
  config = function()
    local gf = require "grug-far"
    gf.setup {
      vim.keymap.set("n", "<leader>gfw", function()
        gf.open { prefills = { search = vim.fn.expand "<cword>" } }
      end, { desc = "grug-far search current word and replace" }),
    }
  end,
}
