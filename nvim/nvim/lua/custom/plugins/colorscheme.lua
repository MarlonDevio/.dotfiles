return {
  -- TokyoNight
  {
    'folke/tokyonight.nvim',
    name = 'tokyonight', -- Optional for better references
    lazy = false, -- You can set to `false` if you want it always loaded
    opts = {
      style = 'storm', -- Example config
      transparent = true,
    },
  },

  -- Rose-Pine
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    lazy = false,
    opts = {
      dark_variant = 'main',
    },
  },

  -- One Dark
  {
    'navarasu/onedark.nvim',
    name = 'onedark',
    lazy = false,
  },

  {
    'scottmckendry/cyberdream.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true,
      italic_comments = true,
      borderless_telescope = true,
      terminal_colors = true,
    },
  },
  -- Add as many more as you like...
}
