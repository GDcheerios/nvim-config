-- load configs
require("config.lazy")
require("config.keymaps")
require("config.lsp")

-- settings
vim.cmd([[syntax on]])
vim.cmd([[filetype plugin indent on]])

-- colorscheme
vim.opt.termguicolors = true
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy", -- LazyNvim hook
  callback = function()
    vim.cmd("colorscheme GDcheeriosTheme")
  end,
})
