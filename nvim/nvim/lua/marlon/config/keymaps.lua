-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('x', '<leader>pp', [["_dP]])
vim.api.nvim_set_keymap('n', '<leader>x', ':bdelete<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-f>', ':terminal<CR>', { noremap = true, silent = true })

-- Global variable to store the last used language
_G.last_language = ''

-- Function to insert the code block with a user-defined language or the last used language
function _G.insert_code_block()
  -- Prompt the user for the language, with the last used language as the default
  local language = vim.fn.input('Enter language [' .. (_G.last_language ~= '' and _G.last_language or 'none') .. ']: ')

  -- Use the last used language if the input is empty
  if language == '' and _G.last_language ~= '' then
    language = _G.last_language
  elseif language ~= '' then
    -- Update the last used language if a new one is provided
    _G.last_language = language
  end

  -- Insert the code block with the specified or last used language
  vim.api.nvim_put({ '```' .. language, '', '```' }, 'c', true, true)

  -- Move the cursor to the new line inside the code block
  vim.api.nvim_command 'startinsert'
end

-- Autocommand to set up the keybinding in markdown files
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = function()
    vim.api.nvim_buf_set_keymap(0, 'n', '<leader>cb', ':lua insert_code_block()<CR>', { noremap = true, silent = true })
  end,
})
