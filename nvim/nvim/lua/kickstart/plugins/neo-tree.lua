-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '<C-n>', ':Neotree toggle<CR>', desc = 'NeoTree reveal', silent = true },
  },
  opts = {
    filesystem = {
      hijack_netrw = true,
      window = {
        mappings = {
          ['<C-n>'] = 'close_window',
        },
      },
    },
  },
  config = function(_, opts)
    local tree = require 'neo-tree'
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    tree.setup(opts)
  end,
}
