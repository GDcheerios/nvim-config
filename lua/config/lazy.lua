local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Core plugins
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
  { "nvim-tree/nvim-tree.lua", dependencies = { "nvim-tree/nvim-web-devicons" } },
  { "nvim-lualine/lualine.nvim" },
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

  -- LSP and Autocompletion
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("mason").setup()

      local mason_lspconfig = require("mason-lspconfig")

      mason_lspconfig.setup({
        automatic_installation = true,
      })

      for _, server in ipairs(mason_lspconfig.get_installed_servers()) do
        vim.lsp.config(server, {})
        vim.lsp.enable(server)
      end
    end,
  },
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "L3MON4D3/LuaSnip" },

  -- Quality of life
  { "numToStr/Comment.nvim", opts = {}, lazy = false },
  { "folke/which-key.nvim", opts = {} },
  { "folke/todo-comments.nvim", dependencies = { "nvim-lua/plenary.nvim" }, opts = {}, lazy = false },
  { 'nvim-mini/mini.nvim', version = '*', config = function() require('mini.surround').setup() end },
  { "folke/noice.nvim" },
  { "akinsho/bufferline.nvim" },
  { "lukas-reineke/indent-blankline.nvim" },


  -- extras
  {'vyfor/cord.nvim'}
})
