return {
  {
    "github/copilot.vim",
    lazy = false,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "github/copilot.vim" }, -- or github/copilot.vim
      { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
      { "nvim-telescope/telescope.nvim" }, -- for curl, log wrapper
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    keys = {
      { "<leader>ccq", desc = "CopilotChat - Quick chat" },
      { "<leader>cch", desc = "CopilotChat - Help actions" },
      { "<leader>ccp", desc = "CopilotChat - Prompt actions" },
      { "<leader>cct", desc = "CopilotChat - CopilotChat toggle" },
    },
    opts = {
      debug = true, -- Enable debugging
      prompts = {
        MyCustomPrompt = {
          prompt = "Explain how it works.",
          mapping = "<leader>ccmc",
          description = "My custom prompt description",
          -- selection = require('CopilotChat.select').visual, -- Commented out since it causes an error
        },
      },
      -- Additional configurations
    },
    config = function()
      -- Key mappings for lazy loading
      local actions = require "CopilotChat.actions"
      local chat = require "CopilotChat"

      vim.keymap.set("n", "<leader>ccq", function()
        local input = vim.fn.input "Quick Chat: "
        if input ~= "" then
          require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer }) -- Remove or adjust selection as needed
        end
      end, { desc = "CopilotChat - Quick chat" })

      vim.keymap.set("n", "<leader>cch", function()
        require("CopilotChat.integrations.telescope").pick(actions.help_actions())
      end, { desc = "CopilotChat - Help actions" })

      vim.keymap.set("n", "<leader>ccp", function()
        require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
      end, { desc = "CopilotChat - Prompt actions" })

      vim.keymap.set("n", "<leader>cct", function()
        chat.toggle()
      end, { desc = "CopilotChat - CopilotChat toggle" })

      -- Register copilot-chat source for cmp and configure key mappings
      require("CopilotChat").setup {
        mappings = {
          complete = {
            insert = "",
          },
        },
      }

      -- Autocommands for CopilotChat buffers
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "copilot-*",
        callback = function()
          vim.opt_local.relativenumber = true
          vim.keymap.set("n", "<C-p>", function()
            print(require("CopilotChat").response())
          end, { buffer = true, remap = true })
        end,
      })

      -- Set up CMP integration for CopilotChat
      require("CopilotChat.integrations.cmp").setup()
    end,
  },
}
