return {
  "kkoomen/vim-doge",
  lazy = false,
  keys = {
    "<leader>dg",
  },
  config = function()
    vim.keymap.set("n", "<leader>dg", "<cmd>DogeGenerate<cr>")
  end,
}
