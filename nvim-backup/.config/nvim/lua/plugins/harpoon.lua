local M = {}

M = {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
  keys = {
    { "<C-a>", desc = "Harpoon add file to harpoon list" },
    { "<C-e>", desc = "Harpoon open harpoon list in telescope" },
    { "<C-p>", desc = "Harpoon open menu" },
    { "<leader>c1" },
    { "<leader>c2" },
    { "<leader>c3" },
    { "<leader>c4" },
    { "<leader>cp" },
    { "<leader>cn" },
  },

  config = function()
    local harpoon = require "harpoon"
    local list = harpoon:list()
    local function list_select(num)
      return function()
        list:select(num)
      end
    end
    local map = vim.keymap.set

    harpoon:setup()

    local telescope_conf = require("telescope.config").values
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require("telescope.pickers")
        .new({}, {
          prompt_title = "Harpoon",
          finder = require("telescope.finders").new_table {
            results = file_paths,
          },
          previewer = telescope_conf.file_previewer {},
          sorter = telescope_conf.generic_sorter {},
        })
        :find()
    end

    map("n", "<C-a>", function()
      list:add()
    end, { desc = "Harpoon add file to harpoon list" })

    map("n", "<C-p>", function()
      harpoon.ui:toggle_quick_menu(list)
    end, { desc = "Harpoon open list in menu" })

    map("n", "<C-e>", function()
      toggle_telescope(list)
    end, { desc = "Harpoon open harpoon list in telescope" })

    map("n", "<leader>c1", list_select(1))
    map("n", "<leader>c2", list_select(2))
    map("n", "<leader>c3", list_select(3))
    map("n", "<leader>c4", list_select(4))

    map("n", "<leader>cp", function()
      list:prev()
    end, { desc = "Harpoon goto previous" })
    map("n", "<leader>cn", function()
      list:next()
    end, { desc = "Harpoon goto next" })
    return harpoon
  end,
}

return M
