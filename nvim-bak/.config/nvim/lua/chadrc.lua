-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "ayu_light",
  transparency = false,
  hl_override = {
    ["@comment"] = { italic = true },
    ["@keyword"] = { italic = true, bold = true },
  },
}

M.ui = {
  tabufline = {
    order = { "treeOffset", "buffers", "tabs", "btns" },
  },
  statusline = {
    theme = "default",
    separator_style = "arrow",
  },
} -- Set environment variable when Neovim starts or resumes
vim.api.nvim_create_autocmd({ "VimEnter", "VimResume" }, {
  group = vim.api.nvim_create_augroup("KittyIntegration", { clear = true }),
  callback = function()
    io.stdout:write "\x1b]1337;SetUserVar=IN_EDITOR=MQo\007"
  end,
})

-- Unset environment variable when Neovim loses focus
vim.api.nvim_create_autocmd({ "VimLeave", "VimSuspend" }, {
  group = vim.api.nvim_create_augroup("KittyUnsetVarVimLeave", { clear = true }),
  callback = function()
    io.stdout:write "\x1b]1337;SetUserVar=IN_EDITOR\007"
  end,
})

return M
