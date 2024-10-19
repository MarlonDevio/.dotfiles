local project = {

  "ahmedkhalf/project.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "nvim-tree/nvim-tree.lua",
  },

  keys = {
    { "<space>lr" },
    { "<C-n>" },
  },

  config = function()
    local nvim_tree = require "nvim-tree"
    local nvim_tree_api = require "nvim-tree.api"
    nvim_tree.setup {
      sync_root_with_cwd = true,
      respect_buf_cwd = true,
      update_focused_file = {
        enable = true,
        update_root = true,
      },
      vim.keymap.set({ "n", "x", "i" }, "<C-n>", function()
        nvim_tree_api.tree.toggle()
      end, { desc = "NvimTree Toggle" }),
    }
    -- nvim-tree setup
    -- project.nvim setup
    local p = require("project_nvim").setup {
      -- Automatically change to the root directory without manual intervention
      manual_mode = false,

      -- Detect the root directory using LSP and fallback to pattern matching
      detection_methods = { "lsp", "pattern" },

      -- Define patterns to detect the root directory, including composer.json and src
      patterns = { ".git", "composer.json", "Makefile", "package.json", "=src" },

      -- Ignore specific LSP servers if necessary
      ignore_lsp = {},

      -- You can exclude certain directories from being detected as root dirs
      exclude_dirs = {},

      -- Show hidden files in Telescope
      show_hidden = false,

      -- Suppress the directory change messages
      silent_chdir = true,

      -- Global directory change scope
      scope_chdir = "win",

      -- Path for storing project history for Telescope
      datapath = vim.fn.stdpath "data",
    }

    -- Load project extension for Telescope
    require("telescope").load_extension "projects"
    -- Keybindings for Project and Telescope
    vim.keymap.set("n", "<space>lr", function()
      require("telescope").extensions.projects.projects {}
    end, { desc = "Project show projects" })

    return p
  end,
}
return project
