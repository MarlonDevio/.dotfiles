-- File type detection (for .blade.php files)
vim.filetype.add {
  pattern = {
    [".*%.blade%.php"] = "blade",
  },
}
