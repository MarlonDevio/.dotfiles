local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities
-- load defaults i.e lua_lsp

local lspconfig = require "lspconfig"
-- list of all servers configured
lspconfig.servers = {
  "lua_ls",
  "pyright",
  "html",
  "cssls",
  "omnisharp",
  "intelephense",
  "ast_grep",
  "ts_ls",
  "emmet_ls",
  "tailwindcss",
  "rust_analyzer",
  "clangd",
  "bashls",
  "texlab",
  "eslint",
}

local default_servers = {
  -- "pyright",
  "bashls",
  "clangd",
  "html",
  "cssls",
  "pyright",
  "ast_grep",
  "ts_ls",
  "emmet_ls",
  "tailwindcss",
  "rust_analyzer",
  "texlab",
  "eslint",
}

-- lsps with default config
for _, lsp in ipairs(default_servers) do
  -- if lsp == "tsserver" then
  --   lsp = "ts_ls"
  -- end
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

lspconfig.lua_ls.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,

  settings = {
    Lua = {
      diagnostics = {
        enable = true,
        globals = { "vim" },
      },
      workspace = {
        library = {
          vim.fn.expand "$VIMRUNTIME/lua",
          vim.fn.expand "$VIMRUNTIME/lua/vim/lsp",
          vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types",
          vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy",
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
    },
  },
}

local omnisharp_bin = "/Users/marlon/bin/omnisharp-roselyn/OmniSharp"
local pid = vim.fn.getpid()
local util = require "lspconfig.util"
lspconfig.omnisharp.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  cmd = {
    omnisharp_bin,
    "--languageserver",
    "--hostPID",
    tostring(pid),
  },
  settings = {
    FormattingOptions = {
      EnableEditorConfigSupport = true,
      OrganizeImports = true,
    },
    MsBuild = {
      LoadProjectsOnDemand = nil,
    },
    RoslynExtensionsOptions = {
      EnableAnalyzersSupport = true,
      EnableImportCompletion = true,
      AnalyzeOpenDocumentsOnly = false,
    },
    Sdk = {
      IncludePrereleases = true,
    },
    diagnostics = {
      enable = true,
      hint = true,
      warning = true,
      virtualText = false,
      information = true,
      severity = {
        error = "Error",
        warning = "Warning",
        hint = "Hint",
        information = "Information",
      },
    },
  },
  filetypes = { "cs", "csx", "xaml" },
  root_dir = util.root_pattern("*.sln", "*.csproj", "omnisharp.json", "function.json"),
}

-- In your lspconfig.lua file
lspconfig.intelephense.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  filetypes = { "php", "blade", "php_only" },
  settings = {
    intelephense = {
      filetypes = { "php", "blade", "php_only" },
      files = {
        associations = { "*.php", "*.blade.php" },
        maxSize = 5000000,
        exclude = {
          "**/node_modules/**",
        },
      },
      stubs = {
        "apache",
        "bcmath",
        "bz2",
        "calendar",
        "com_dotnet",
        "Core",
        "curl",
        "date",
        "dba",
        "dom",
        "enchant",
        "fileinfo",
        "filter",
        "ftp",
        "gd",
        "gettext",
        "hash",
        "iconv",
        "imap",
        "intl",
        "json",
        "ldap",
        "libxml",
        "mbstring",
        "mcrypt",
        "mysql",
        "mysqli",
        "password",
        "pcntl",
        "pcre",
        "PDO",
        "pdo_mysql",
        "Phar",
        "readline",
        "recode",
        "Reflection",
        "regex",
        "session",
        "SimpleXML",
        "soap",
        "sockets",
        "sodium",
        "SPL",
        "standard",
        "superglobals",
        "tokenizer",
        "xml",
        "xdebug",
        "xmlreader",
        "xmlwriter",
        "yaml",
        "zip",
        "zlib",
        "wordpress", -- Add WordPress stubs
        "woocommerce", -- Add WooCommerce stubs
      },
    },
  },
}

-- configuring single server, example: typescript
-- lspconfig.tsserver.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }
