return {
  "windwp/nvim-ts-autotag",
  ft = { "html", "xml", "javascript", "typescript", "javascriptreact", "typescriptreact", "vue", "svelte" }, -- Specify filetypes here
  config = function()
    local o = require "nvim-ts-autotag"
    o.setup {
      opts = {
        -- Defaults
        enable_close = true, -- Auto close tags
        enable_rename = true, -- Auto rename pairs of tags
        enable_close_on_slash = false, -- Auto close on trailing </
      },
    }
    return o
  end,
}
