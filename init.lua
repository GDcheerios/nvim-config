-- settings
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.wrap = false
vim.opt.sidescrolloff = 8
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

vim.opt.foldmethod = "marker"
vim.opt.foldmarker = "# region,# endregion"
vim.opt.foldlevel = 99

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.softtabstop = 4

-- clipboard (syncs with Windows clipboard & Wayland wl-clipboard on Arch)
vim.opt.clipboard = "unnamedplus"

-- colorscheme
vim.opt.termguicolors = true

-- load configs
require("config.lazy")
require("config.keymaps")
require("custom.colorscheme").apply()
