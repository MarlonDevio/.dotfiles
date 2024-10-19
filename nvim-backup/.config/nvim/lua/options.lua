require "nvchad.options"

-- add yours here!

local o = vim.o
o.cursorlineopt = "both" -- to enable cursorline!
o.conceallevel = 2
o.scrolloff = 10
o.number = true
o.relativenumber = true
o.swapfile = false

local enable_providers = {
  "python3_provider",
  "node_provider",
  -- and so on
}

for _, plugin in pairs(enable_providers) do
  vim.g["loaded_" .. plugin] = nil
  vim.cmd("runtime " .. plugin)
end
-- Highlight group for yanked text
vim.api.nvim_set_hl(0, "YankHighlight", {
  bg = "#FFFF00", -- Yellow background
  fg = "#000000", -- Black text (optional)
})

-- Autocommand to trigger on TextYankPost
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank {
      higroup = "YankHighlight", -- Highlight group name
      timeout = 100, -- Duration in milliseconds
    }
  end,
})
