vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.cmd 'let g:netrw_liststyle = 3'
-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

require 'marlon.config'
require 'current-theme'

-- Save the cursor position explicitly when saving the file
vim.api.nvim_create_autocmd('BufWritePost', {
  callback = function()
    -- Save current cursor position to mark '"'
    vim.api.nvim_command 'normal! m"'
  end,
})

-- Restore the cursor position when reopening a file
vim.api.nvim_create_autocmd('BufReadPost', {
  callback = function()
    local last_pos = vim.fn.line '\'"' -- Get the last cursor position from the '" mark
    local total_lines = vim.fn.line '$' -- Get the total number of lines in the file

    -- If the last position is valid within the current file
    if last_pos > 0 and last_pos <= total_lines then
      vim.api.nvim_command 'normal! g`"' -- Restore to the saved position
    elseif last_pos > total_lines then
      vim.api.nvim_command 'normal! G' -- Move to the last line if the file has fewer lines
    end
  end,
})
