local nvlsp = require("nvchad.configs.lspconfig")
nvlsp.defaults()

nvlsp.capabilities.textDocument.semanticHighlightingCapabilities = {
  semanticHighlighting = true
}

local lspconfig = require("lspconfig")
local util = require("lspconfig.util")

local servers = {
  "html",
  "cssls",
  "glsl_analyzer",
  "tailwindcss",
  "svelte",
  "clangd",
  "jdtls",
}

for _, srv in ipairs(servers) do
  if srv == "clangd" then
    lspconfig.clangd.setup {
      on_attach    = nvlsp.on_attach,
      on_init      = nvlsp.on_init,
      capabilities = nvlsp.capabilities,
      cmd          = { "clangd", "--background-index", "--clang-tidy" },
      filetypes    = { "c", "cpp", "objc", "objcpp" },
      root_dir     = require("lspconfig.util").root_pattern("compile_commands.json", ".git"),
    }
  elseif srv == "jdtls" then
    lspconfig.jdtls.setup{
      on_attach = nvlsp.on_attach,
      on_init = nvlsp.on_init,
      capabilities = nvlsp.capabilities,
      root_dir = util.root_pattern("pom.xml", "build.gradle", ".git"),
      settings = {
         java = {
            format = {
                profile = "custom", -- You can name this anything
                url = vim.fn.expand("~/.config/nvim/java-formatter.xml"),
              },
            },
         },
      }
  else
    lspconfig[srv].setup {
      on_attach    = nvlsp.on_attach,
      on_init      = nvlsp.on_init,
      capabilities = nvlsp.capabilities,
    }
  end
end
