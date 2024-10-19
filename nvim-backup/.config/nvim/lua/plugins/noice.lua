-- ~/.config/nvim/lua/custom/plugins.lua

return {

  {
    "rcarriga/nvim-notify",
    config = function()
      require("notify").setup {
        background_colour = "#1e1e2e", -- Replace with your desired color
        -- You can add more nvim-notify configurations here if needed
      }

      -- Define the 'NotifyBackground' highlight group
      vim.cmd [[
        highlight NotifyBackground guibg=#1e1e2e
      ]]
    end,
  },
  -- Other plugin specifications...

  -- noice.nvim configuration

  {
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    event = "VeryLazy",
    opts = {
      signature = {
        enabled = false,
      },
    },
    config = function()
      require("noice").setup {
        -- Add your noice.nvim configurations here
        lsp = {
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
          hover = { enabled = false },
          signature = { enabled = false },
        },
        presets = {
          bottom_search = true,
          command_palette = true,
          long_message_to_split = true,
          inc_rename = false,
          lsp_doc_border = false,
        },
        -- Highlight group 'NotifyBackground' has no background highlight
        -- Please provide an RGB hex value or highlight group with a background value for 'background_colour' option.
        -- This is the colour that will be used for 100% transparency.
        -- ```lua
        -- require("notify").setup({
        --   background_colour = "#000000",
        -- })
        -- ```
      }
    end,
  },
}
