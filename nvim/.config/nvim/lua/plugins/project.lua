local project = {
  "ahmedkhalf/project.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  keys = {
    { "<space>l" },
  },
  config = function()
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
      scope_chdir = "global",

      -- Path for storing project history for Telescope
      datapath = vim.fn.stdpath "data",
    }

    require("telescope").load_extension "projects"

    vim.keymap.set("n", "<space>lp", function()
      require("telescope").extensions.projects.projects {}
    end)
    vim.keymap.set("n", "<space>l", function() end)
    return p
  end,
}

return project
