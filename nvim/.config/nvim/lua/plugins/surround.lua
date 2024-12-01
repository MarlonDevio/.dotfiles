-- lua/custom/plugins.lua

local m = {
  -- Other plugin configurations can go here

  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    opts = function(_, opts)
      -- Extend the existing 'surrounds' table with your custom surround
      local utils = require "nvim-surround.utils"

      opts.surrounds = opts.surrounds or {}
      opts.surrounds["w"] = {
        add = function()
          return { { "[[" }, { "]]" } }
        end,
        find = function()
          -- Pattern to find existing wikilinks
          return utils.get_selection {
            pattern = "%[%[.-%]%]",
          }
        end,
        delete = function()
          -- Patterns to delete wikilinks and trim spaces
          return utils.get_selections {
            char = "w",
            pattern = "(%[%[)().-(%]%])()",
          }
        end,
        change = {
          target = function()
            -- Patterns to change wikilinks and trim spaces
            return utils.get_selections {
              char = "w",
              pattern = "(%[%[)().-(%]%])()",
            }
          end,
        },
      }

      -- Return the modified options table
      return opts
    end,
  },
}

return m
