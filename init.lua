-- settings
vim.cmd([[syntax on]])
vim.cmd([[filetype plugin indent on]])

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.foldmethod = "marker"
vim.opt.foldmarker = "# region,# endregion"
vim.opt.foldlevel = 99

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.softtabstop = 4

-- colorscheme
vim.opt.termguicolors = true
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy", -- LazyNvim hook
  callback = function()
    vim.cmd("colorscheme GDcheeriosTheme")
  end,
})

-- load configs
require("config.lazy")
require("config.keymaps")
