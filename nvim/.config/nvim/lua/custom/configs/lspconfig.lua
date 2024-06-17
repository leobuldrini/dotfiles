local base = require("plugins.configs.lspconfig")
local on_attach = base.on_attach
local capabilities = base.capabilities

local lspconfig = require("lspconfig")

lspconfig.clangd.setup {
  on_attach = function(client, bufnr)
    client.server_capabilities.signatureHelpProvider = false
    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
}

local dartExcludedFolders = {
  vim.fn.expand("$HOME/AppData/Local/Pub/Cache"),
  vim.fn.expand("$HOME/.pub-cache"),
  vim.fn.expand("/opt/homebrew/"),
  vim.fn.expand("$HOME/tools/flutter/"),
}

lspconfig.pyright.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "python" },
})
lspconfig.dartls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = {
    "dart",
    "language-server",
    "--protocol=lsp",
    -- "--port=8123",
    -- "--instrumentation-log-file=/Users/robertbrunhage/Desktop/lsp-log.txt",
  },
  filetypes = { "dart" },
  init_options = {
    onlyAnalyzeProjectsWithOpenFiles = false,
    suggestFromUnimportedLibraries = true,
    closingLabels = true,
    outline = false,
    flutterOutline = false,
  },
  settings = {
    dart = {
      analysisExcludedFolders = dartExcludedFolders,
      updateImportsOnRename = true,
      completeFunctionCalls = true,
      showTodos = true,
    },
  },
})

lspconfig.tsserver.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  init_options = {
    preferences = {
      disableSuggestions = true,
    },
  }
})
require("dart-tools")
