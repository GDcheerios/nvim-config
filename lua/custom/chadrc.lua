local M = {}

M.ui = {
  theme = "custom",
  hl_override = require("custom.colorscheme").plugins,
  statusline = {
    theme = "custom",
    config = require("custom.statusline")
  },
}

return M
