return {
  'nvim-telescope/telescope-file-browser.nvim',
  lazy = true,
  dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
  keys = {
    '<space>fb',
  },
  config = function(_, opts)
    vim.keymap.set('n', '<space>fb', function()
      require('telescope').extensions.file_browser.file_browser()
    end, { desc = 'telescope search filebrowser' })
  end,
}
