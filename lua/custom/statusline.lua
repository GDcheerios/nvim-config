local heirline = require("heirline")
local conditions = require("heirline.conditions")
local colors = require("custom.colorscheme").base

local mode_names = {
  n = "NORMAL",
  no = "OP-PENDING",
  v = "VISUAL",
  V = "V-LINE",
  ["\22"] = "V-BLOCK",
  i = "INSERT",
  ic = "INSERT",
  R = "REPLACE",
  c = "COMMAND",
  t = "TERMINAL",
}

local mode_colors = {
  n = colors.accent,
  i = colors.fg,
  v = colors.warn,
  V = colors.warn,
  ["\22"] = colors.warn,
  c = colors.accent2,
  t = colors.success,
}

local Mode = {
  provider = function()
    local m = vim.fn.mode()
    local label = mode_names[m] or m:upper()
    return " [" .. label .. "] "
  end,
  hl = function()
    local m = vim.fn.mode()
    return {
      fg = mode_colors[m] or colors.accent,
      bg = colors.bg_elev1,
      bold = true,
    }
  end,
}

local FileName = {
  provider = function()
    local name = vim.fn.expand("%:t")
    if name == "" then
      name = "[No Name]"
    end
    local mod = vim.bo.modified and " [+]" or ""
    local ro = vim.bo.readonly and " [RO]" or ""
    return " " .. name .. mod .. ro .. " "
  end,
  hl = { fg = colors.fg, bg = colors.bg_elev1 },
}

local Git = {
  condition = conditions.is_git_repo,
  init = function(self)
    self.status_dict = vim.b.gitsigns_status_dict or {}
  end,
  hl = { bg = colors.bg_elev1 },
  {
    provider = function(self)
      return "| git:" .. (self.status_dict.head or "") .. " "
    end,
    hl = { fg = colors.accent2 },
  },
  {
    provider = function(self)
      local s = self.status_dict
      local added = s.added or 0
      local changed = s.changed or 0
      local removed = s.removed or 0
      if (added + changed + removed) == 0 then
        return ""
      end
      return string.format("(+%s ~%s -%s) ", added, changed, removed)
    end,
    hl = { fg = colors.muted },
  },
}

local Diagnostics = {
  condition = conditions.has_diagnostics,
  hl = { bg = colors.bg_elev1 },
  {
    provider = function()
      local n = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
      return n > 0 and ("| E:" .. n .. " ") or ""
    end,
    hl = { fg = colors.error, bold = true },
  },
  {
    provider = function()
      local n = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
      return n > 0 and ("W:" .. n .. " ") or ""
    end,
    hl = { fg = colors.warn },
  },
  {
    provider = function()
      local n = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
      return n > 0 and ("I:" .. n .. " ") or ""
    end,
    hl = { fg = colors.muted },
  },
}

local Ruler = {
  provider = " %l:%c | %p%% ",
  hl = { fg = colors.accent, bg = colors.bg_elev1 },
}

local statusline = {
  hl = { fg = colors.fg, bg = colors.bg_elev1 },
  Mode,
  FileName,
  Git,
  Diagnostics,
  { provider = "%=" },
  Ruler,
}

heirline.setup({
  statusline = statusline,
})

return statusline