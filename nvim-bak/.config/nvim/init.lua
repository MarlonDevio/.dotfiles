vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
vim.g.mapleader = " "
require "configs.filetypes"
-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"
vim.schedule(function()
  require "mappings"
end)
vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { underline = false })
-- init.lua
--- Auto sort Tailwind CSS classes on save
-- vim.cmd [[
--   augroup MyCustomTailwindSortGroup
--     autocmd!
--     autocmd BufWritePost *.html,*.js,*.jsx,*.ts,*.tsx TailwindSort
--   augroup END
-- ]]

-- Load Lazy.nvim (assuming you have it already set up in your init.lua)
--#region
--

-- Save the cursor position explicitly when saving the file
vim.api.nvim_create_autocmd("BufWritePost", {
  callback = function()
    -- Save current cursor position to mark '"'
    vim.api.nvim_command 'normal! m"'
  end,
})

-- Restore the cursor position when reopening a file
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local last_pos = vim.fn.line "'\"" -- Get the last cursor position from the '" mark
    local total_lines = vim.fn.line "$" -- Get the total number of lines in the file

    -- If the last position is valid within the current file
    if last_pos > 0 and last_pos <= total_lines then
      vim.api.nvim_command 'normal! g`"' -- Restore to the saved position
    elseif last_pos > total_lines then
      vim.api.nvim_command "normal! G" -- Move to the last line if the file has fewer lines
    end
  end,
})
