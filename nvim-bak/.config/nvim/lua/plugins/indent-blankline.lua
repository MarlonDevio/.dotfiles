return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  ---@module "ibl"
  ---@type ibl.config
  opts = {},
  config = function()
    local highlight = {
      "RainbowRed",
      "RainbowYellow",
      "RainbowBlue",
      "RainbowOrange",
      "RainbowGreen",
      "RainbowViolet",
      "RainbowCyan",
    }

    local hooks = require "ibl.hooks"
    -- create the highlight groups in the highlight setup hook, so they are reset
    -- every time the colorscheme changes
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#F28FAD" }) -- Lighter Red
      vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#F2C94C" }) -- Lighter Yellow
      vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#7AB8F7" }) -- Lighter Blue
      vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#F2A65A" }) -- Lighter Orange
      vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#A3D977" }) -- Lighter Green
      vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#B493D4" }) -- Lighter Violet
      vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#70C0BA" }) -- Lighter Cyan
    end)
    require("ibl").setup { indent = { char = "│", highlight = highlight } }
  end,
}
