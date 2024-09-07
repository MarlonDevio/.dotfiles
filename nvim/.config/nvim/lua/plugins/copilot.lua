return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
      { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    keys = {
      { "<leader>ccq", desc = "CopilotChat - Quick chat" },
      { "<leader>cch", desc = "CopilotChat - Help actions" },
      { "<leader>ccp", desc = "CopilotChat - Prompt actions" },
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
      vim.keymap.set("n", "<leader>ccq", function()
        local input = vim.fn.input "Quick Chat: "
        if input ~= "" then
          require("CopilotChat").ask(input, { selection = nil }) -- Remove or adjust selection as needed
        end
      end, { desc = "CopilotChat - Quick chat" })

      vim.keymap.set("n", "<leader>cch", function()
        local actions = require "CopilotChat.actions"
        require("CopilotChat.integrations.fzflua").pick(actions.help_actions())
      end, { desc = "CopilotChat - Help actions" })

      vim.keymap.set("n", "<leader>ccp", function()
        local actions = require "CopilotChat.actions"
        require("CopilotChat.integrations.fzflua").pick(actions.prompt_actions())
      end, { desc = "CopilotChat - Prompt actions" })

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
