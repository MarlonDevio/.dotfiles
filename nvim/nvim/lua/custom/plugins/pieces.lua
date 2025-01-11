return {
  'pieces-app/plugin_neo_vim',
  lazy = 'VeryLazy',
  config = function()
    local map = vim.keymap.set
    map('n', '<leader>scs', '<cmd>PiecesSnippets<CR>')
  end,
}
