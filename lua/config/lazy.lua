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
      automatic_installation = true
    })

    -- enable normal LSP servers
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
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
        -- add any options here
    },
    dependencies = {
        -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
        "MunifTanjim/nui.nvim",
        -- OPTIONAL:
        --   `nvim-notify` is only needed, if you want to use the notification view.
        --   If not available, we use `mini` as the fallback
        "rcarriga/nvim-notify",
    }
  },
  { 'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons', config = function() require('bufferline').setup() end },
  { "lukas-reineke/indent-blankline.nvim", config = function() require('ibl').setup() end },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "auto",
          section_separators = "",
          component_separators = "",
        },
      })
    end,
  },
  {
    "rebelot/heirline.nvim",
    event = "VeryLazy",
    config = function()
      require("custom.statusline")
    end,
  },
  { "lewis6991/gitsigns.nvim", config = true },
  {
    "NvChad/nvim-colorizer.lua",
    event = "BufReadPre",
    config = function()
      require("colorizer").setup({
        "*", -- enable for all filetypes
      }, {
        RGB      = true,
        RRGGBB   = true,
        names    = true,
        RRGGBBAA = true,
        css      = true,
        css_fn   = true,
      })
    end,
  },




  -- extras
  {'vyfor/cord.nvim'}
})
