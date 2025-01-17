-- File: lua/search.lua
local M = {}

function M.search_with_telescope()
  local input_string = vim.fn.input 'Search For > '
  if input_string == '' then
    return
  end
  require('telescope.builtin').grep_string {
    search = input_string,
  }
end

return M
