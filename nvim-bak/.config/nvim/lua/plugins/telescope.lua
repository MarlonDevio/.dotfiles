local map = vim.keymap.set
local builtin = require "telescope.builtin"
local telescope = {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-tree/nvim-web-devicons",
    },

    opts = function()
      local conf = require "nvchad.configs.telescope"
      -- Add or extend file_ignore_patterns
      conf.defaults.file_ignore_patterns = vim.list_extend(
        conf.defaults.file_ignore_patterns or {}, -- Preserve existing ignore patterns
        {
          "node%_modules",
          "pynvim%-venv",
          "pynvim%-venv/.*",
          "pynvim%-venv/**",
          "pynvim%-venv/**/.*",
          "vendor",
          ".*/%a*conda.*/.*",
          ".*/%w*conda.*%w.+?/.*",
        } -- Escaping the hyphen
      )

      conf.defaults.mappings.i = {

        map("n", "<leader>sk", builtin.keymaps, { desc = "telescope search keymap" }),
        map("n", "<leader>sg", "<cmd>Telescope live_grep<CR>", { desc = "telescope live grep" }),
        map("n", "<leader><leader>", "<cmd>Telescope buffers<CR>", { desc = "telescope find buffers" }),
        map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "telescope help page" }),
        map("n", "<leader>sm", "<cmd>Telescope marks<CR>", { desc = "telescope find marks" }),
        map("n", "<leader>s.", "<cmd>Telescope oldfiles<CR>", { desc = "telescope find oldfiles" }),
        map(
          "n",
          "<leader>sz",
          "<cmd>Telescope current_buffer_fuzzy_find<CR>",
          { desc = "telescope find in current buffer" }
        ),
        map("n", "<leader>cm", "<cmd>Telescope git_commits<CR>", { desc = "telescope git commits" }),
        map("n", "<leader>gt", "<cmd>Telescope git_status<CR>", { desc = "telescope git status" }),
        map("n", "<leader>st", "<cmd>Telescope terms<CR>", { desc = "telescope pick hidden term" }),
        map("n", "<leader>th", "<cmd>Telescope themes<CR>", { desc = "telescope nvchad themes" }),
        map("n", "<leader>sf", "<cmd>Telescope find_files<cr>", { desc = "telescope find files" }),
        map(
          "n",
          "<leader>fa",
          "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
          { desc = "telescope find all files" }
        ),

        map("n", "<leader>ss", builtin.builtin, { desc = "telescope search select telescope" }),
        map("n", "<leader>s/", function()
          builtin.find_files {
            prompt_title = "Search Root",
            shorten_path = true,
            path_display = { "tail" },
            search_dirs = { "/Users/marlon/" },
          }
        end, { desc = "telescope search home directory" }),
        map("n", "<leader>sof", function()
          builtin.find_files {
            prompt_title = "Search Obsidian Files",
            shorten_path = true,
            path_display = { "tail" },
            search_dirs = {
              "/Users/marlon/vaults/Life/",
            },
          }
        end, { desc = "Telescope search obsidian files" }),
        map("n", "<leader>sog", function()
          builtin.live_grep {
            prompt_title = "Search Obsidian Grep",
            shorten_path = true,
            path_display = { "tail" },
            search_dirs = {
              "/Users/marlon/vaults/Life/",
            },
          }
        end, { desc = "Telescope Live Grep obsidian files" }),

        map("n", "<leader>s/", function()
          builtin.find_files {
            prompt_title = "Search Root",
            shorten_path = true,
            path_display = { "tail" },
            search_dirs = { "/Users/marlon/" },
          }
        end, { desc = "telescope search home directory" }),

        map("n", "<leader><leader>", function()
          builtin.oldfiles {
            prompt_title = "Find recent files",
            shorten_path = true,
            path_display = { "absolute" },
            search_dirs = { "/" },
          }
        end, { desc = "telescope search old files" }),

        map("n", "<leader>sn", function()
          builtin.find_files { cwd = vim.fn.stdpath "config" }
        end, { desc = "telescope search neovim config files" }),

        -- or
        -- table.insert(conf.defaults.mappings.i, your table)
      }
      conf.pickers = {
        find_files = {
          mappings = {
            n = {
              -- Map <C-q> to send selected items to quickfix list and open it
              ["<C-q>"] = function(prompt_bufnr)
                local actions = require "telescope.actions"
                actions.send_selected_to_qflist(prompt_bufnr)
                actions.open_qflist()
              end,
            },
          },
        },
      }
      conf.extensions = {
        file_browser = {
          hijack_netrw = true,
        },
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      }

      return conf
    end,

    config = function(_, opts)
      require("telescope").setup(opts)
      require("telescope").load_extension "fzf"
      require("telescope").load_extension "file_browser"
    end,
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    keys = { "<leader>fb" },
  },
}
return telescope
