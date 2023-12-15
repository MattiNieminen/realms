local configs = require("plugins.configs.lspconfig")
local on_attach = configs.on_attach
local capabilities = configs.capabilities

local lspconfig = require "lspconfig"

lspconfig.azure_pipelines_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    yaml = {
      schemas = {
        ["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json"] = {
          "automation/*.y*l"
        }
      }
    }
  }
}

lspconfig.bicep.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = {
    "dotnet",
    "/Users/matti.nieminen/realms/dune/.local/share/nvim/mason/packages/bicep-lsp/extension/bicepLanguageServer/Bicep.LangServer.dll"
  }
}

lspconfig.tsserver.setup {
  on_attach = on_attach,
  capabilities = capabilities
}
