local obsidian = {
  {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
      "nvim-telescope/telescope.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    event = {
      "BufReadPre " .. "/Users/marlon/Library/Mobile Documents/iCloud~md~obsidian/Documents/MainSyncVault/**/*.md",
      "BufNewFile " .. "/Users/marlon/Library/Mobile Documents/iCloud~md~obsidian/Documents/MainSyncVault/**/*.md",
    },
    cmd = {
      "ObsidianOpen",
      "ObsidianNew",
      "ObsidianQuickSwitch",
      "ObsidianFollowLink",
      "ObsidianBacklinks",
      "ObsidianToday",
      "ObsidianYesterday",
      "ObsidianTemplate",
      "ObsidianSearch",
      "ObsidianLink",
      "ObsidianLinks",
      "ObsidianExtractNote",
      "ObsidianLinkNew",
      "ObsidianTags",
    },

    opts = {

      workspaces = {
        {
          name = "MainSyncVault",
          path = "/Users/marlon/Library/Mobile Documents/iCloud~md~obsidian/Documents/MainSyncVault",
          overrides = {
            notes_subdir = "1-rough-notes",
          },
        },
      },

      notes_subdir = "1-rough-notes",
      new_notes_location = "1-rough-notes",

      completion = { nvim_cmp = true, min_chars = 2 },

      disable_frontmatter = false,

      preferred_link_style = "wiki",

      note_frontmatter_func = function(note)
        -- Add the title of the note as an alias.
        if note.title then
          note:add_alias(note.title)
        end

        local out = { date = os.date "%Y-%m-%d %H:%M", id = note.id, aliases = note.aliases, tags = note.tags }

        -- `note.metadata` contains any manually added fields in the frontmatter.
        -- So here we just make sure those fields are kept in the frontmatter.
        if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
          for k, v in pairs(note.metadata) do
            out[k] = v
          end
        end

        return out
      end,
      -- Optional, for templates (see below).
      follow_url_func = function(url)
        vim.fn.jobstart { "open", url }
      end,

      note_id_func = function(title)
        -- Use the title directly as the note ID
        return title
      end,

      note_path_func = function(spec)
        -- This is equivalent to the default behavior.
        local path = spec.dir / tostring(spec.title)
        return path:with_suffix ".md"
      end,

      -- Optional, set to true if you use the Obsidian Advanced URI plugin.
      -- https://github.com/Vinzent03/obsidian-advanced-uri
      use_advanced_uri = true,

      -- Optional, set to true to force ':ObsidianOpen' to bring the app to the foreground.
      open_app_foreground = false,
      ui = {
        enable = true, -- set to false to disable all additional syntax features
        update_debounce = 200, -- update delay after a text change (in milliseconds)
        -- Define how various check-boxes are displayed
        checkboxes = {
          -- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
          [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
          ["x"] = { char = "", hl_group = "ObsidianDone" },
          [">"] = { char = "", hl_group = "ObsidianRightArrow" },
          -- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
          ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
          ["!"] = { char = "", hl_group = "ObsidianImportant" },
          -- Re   ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
          -- Replace the above with this if you don't have a patched font:
          -- [" "] = { char = "☐", hl_group = "ObsidianTodo" },
          -- ["x"] = { char = "✔", hl_group = "ObsidianDone" },

          -- You can also add more custom ones...
        },
        external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
        -- Replace the above with this if you don't have a patched font:
        -- external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
        reference_text = { hl_group = "ObsidianRefText" },
        highlight_text = { hl_group = "ObsidianHighlightText" },
        tags = { hl_group = "ObsidianTag" },
        hl_groups = {
          -- The options are passed directly to `vim.api.nvim_set_hl()`. See `:help nvim_set_hl`.
          ObsidianTodo = { bold = true, fg = "#f78c6c" },
          ObsidianDone = { bold = true, fg = "#89ddff" },
          ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
          ObsidianTilde = { bold = true, fg = "#ff5370" },
          ObsidianRefText = { underline = true, fg = "#c792ea" },
          ObsidianExtLinkIcon = { fg = "#c792ea" },
          ObsidianTag = { italic = true, fg = "#89ddff" },
          ObsidianHighlightText = { bg = "#75662e" },
        },
      },
    },

    -- mappings = {
    --   ["gf"] = require("obsidian.mapping").gf_passthrough(),
    -- },

    config = function(_, opts)
      require("obsidian").setup(opts)
      vim.keymap.set("n", "<leader>of", function()
        if require("obsidian").util.cursor_on_markdown_link() then
          return "<cmd>ObsidianFollowLink<CR>"
        end
      end, { desc = "obsidian follow link", noremap = false, expr = true })
      vim.keymap.set("n", "<leader>gf", function()
        require("obsidian").util.gf_passthrough()
      end, { desc = "obsidian passthrough" })
      vim.keymap.set("n", "<leader>on", "<cmd>ObsidianNew<CR>", { desc = "obsidian new note" })
      vim.keymap.set("n", "<leader>oq", "<cmd>ObsidianQuickSwitch<CR>", { desc = "obsidian quick switch" })
      vim.keymap.set("n", "<leader>ot", "<cmd>ObsidianTags<CR>", { desc = "obsidian all occurrences of given tag" })
      vim.keymap.set("n", "<leader>os", "<cmd>ObsidianSearch<CR>", { desc = "obsidian search for or create notes" })
      vim.keymap.set("n", "<leader>ol", "<cmd>ObsidianLinkNew<CR>", { desc = "obsidian create new note and link it" })
      vim.keymap.set("n", "<leader>ob", "<cmd>ObsidianBacklinks<CR>", { desc = "obsidian find all backlinks " })
    end,
  },
}
return obsidian
