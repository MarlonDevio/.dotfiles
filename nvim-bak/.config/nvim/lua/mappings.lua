require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", "<leader>dq", function()
  require("telescope").extensions.dash.search {
    bang = false,
    initial_text = "",
  }
end, { desc = "Dash Search with Telescope" })
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

--- /Users/marlon/.config/nvim-chad-complete/lua/pluginmaps/mappings-leap.lua ---

--- /Users/marlon/.config/nvim-chad-complete/lua/pluginmaps/init.lua ---

--- /Users/marlon/.config/nvim-chad-complete/lua/pluginmaps/mappings-telescope.lua ---

-- Telescope
--- /Users/marlon/.config/nvim-chad-complete/lua/pluginmaps/mappings-tmux-navigator.lua ---

map("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>", { desc = "Tmux navigate left" })
map("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>", { desc = "Tmux navigate down" })
map("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>", { desc = "Tmux navigate up" })
map("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>", { desc = "Tmux navigate right" })
map("n", "<C-\\>", "<cmd>TmuxNavigatePrevious<cr>", { desc = "Tmux navigate previous" })
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
--

-- new terminals
map("n", "<leader>cl", function()
  require("nvchad.term").toggle { pos = "sp" }
end, { desc = "terminal new horizontal term" })

-- toggleable
map({ "n", "t" }, "<C-t>", function()
  require("nvchad.term").toggle { pos = "vsp", id = "vtoggleTerm" }
end, { desc = "terminal toggleable vertical term" })

map({ "n", "t" }, "<A-h>", function()
  require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm" }
end, { desc = "terminal new horizontal term" })

map({ "n", "t" }, "<C-f>", function()
  require("nvchad.term").toggle { pos = "float", id = "floatTerm" }
end, { desc = "terminal toggle floating term" })

-- Alternatively, using lua API
vim.keymap.set("n", "<space>fb", function()
  require("telescope").extensions.file_browser.file_browser()
end, { desc = "telescope search filebrowser" })

map("n", "<leader>sp", function()
  require("spectre").toggle()
end, { desc = "spectre Toggle Spectre" })

-- Global variable to store the last used language
_G.last_language = ""

-- Function to insert the code block with a user-defined language or the last used language
function _G.insert_code_block()
  -- Prompt the user for the language, with the last used language as the default
  local language = vim.fn.input("Enter language [" .. (_G.last_language ~= "" and _G.last_language or "none") .. "]: ")

  -- Use the last used language if the input is empty
  if language == "" and _G.last_language ~= "" then
    language = _G.last_language
  elseif language ~= "" then
    -- Update the last used language if a new one is provided
    _G.last_language = language
  end

  -- Insert the code block with the specified or last used language
  vim.api.nvim_put({ "```" .. language, "", "```" }, "c", true, true)

  -- Move the cursor to the new line inside the code block
  vim.api.nvim_command "startinsert"
end

-- Autocommand to set up the keybinding in markdown files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.api.nvim_buf_set_keymap(0, "n", "<leader>cb", ":lua insert_code_block()<CR>", { noremap = true, silent = true })
  end,
})

map("n", "<leader>tc", "<cmd>tabnew<CR>")
map("n", "<leader>tn", "<cmd>tabnext<CR>")
map("n", "<leader>tp", "<cmd>tabprev<CR>")

map("x", "<leader>pp", [["_dP]])
