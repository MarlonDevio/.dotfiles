local map = vim.keymap.set
local leap = {
  'ggandor/leap.nvim',
  lazy = false,
  keys = {
    { 'f' },
    { 'F' },
    { 'gf' },
  },
  config = function()
    map('n', 'f', '<Plug>(leap)', { desc = 'leap search pattern' })
    map('n', 'F', '<Plug>(leap-from-window)', { desc = 'leap from window' })
    map({ 'x', 'o' }, 'f', '<Plug>(leap-forward)', { desc = 'leap forward pattern' })
    map({ 'x', 'o' }, 'F', '<Plug>(leap-backward)', { desc = 'leap search backward' })
    map({ 'n', 'o' }, 'gF', function()
      require('leap.remote').action()
    end, { desc = 'leap remote action' })
  end,
}
return leap
