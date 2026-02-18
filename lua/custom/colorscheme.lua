local M = {}

M.base = {
  bg        = "#0f0f10",
  bg_elev1  = "#111111",
  bg_elev2  = "#151515",
  border    = "#2b2b2b",
  fg        = "#FFFFFF",
  accent    = "#00d2ff",
  accent2   = "#3a7bd5",
  muted     = "#BFBFBFFF",
  chip_bg   = "#1a1a1a",
  error     = "#E06C75",
  warn      = "#E5C07B",
  info      = "#61AFEF",
  success   = "#98C379",
}

M.plugins = {
  ["nvim-treesitter"] = {
    Normal       = { fg = M.base.fg, bg = M.base.bg },
    Comment      = { fg = M.base.muted, italic = true },
    Constant     = { fg = M.base.accent2 },
    Identifier   = { fg = M.base.accent },
    Function     = { fg = M.base.accent2 },
    Statement    = { fg = M.base.info },
    Type         = { fg = M.base.success },
    Error        = { fg = M.base.error },
  }
}

return M

