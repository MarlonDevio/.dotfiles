-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "bearded-arc",
  transparency = false,
  -- hl_override = {
  Comment = { italic = true },
  -- 	["@comment"] = { italic = true },
  -- },
}

M.ui = {
  tabufline = {
    order = { "treeOffset", "buffers", "tabs", "btns" },
  },
  statusline = {
    theme = "default",
    separator_style = "arrow",
  },
}

return M
