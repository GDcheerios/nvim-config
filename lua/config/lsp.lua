require("mason").setup()

require("mason-lspconfig").setup({
  automatic_installation = true,
})

local lspconfig = require("lspconfig")
local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup_handlers({
  function(server_name)
    lspconfig[server_name].setup({})
  end
})
