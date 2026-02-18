local heirline = require("heirline")
local conditions = require("heirline.conditions")
local utils = require("heirline.utils")

local colors = require("custom.colorscheme").base

-- mode colors
local mode_colors = {
  n = colors.accent,
  i = colors.accent2,
  v = colors.info,
  V = colors.info,
  [""] = colors.info,
  c = colors.warn,
  t = colors.success,
}

-- animated color transition
local function mode_hl()
  local m = vim.fn.mode()
  return {
    fg = mode_colors[m] or colors.fg,
    bg = colors.bg_elev1,
    bold = true,
  }
end

-- FILE ICON
local FileIcon = {
  init = function(self)
    local filename = self.filename
      or vim.api.nvim_buf_get_name(0)

    local extension = vim.fn.fnamemodify(filename, ":e")
    local icon, icon_color =
      require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })

    self.icon = icon
    self.icon_color = icon_color
  end,
  provider = function(self)
    return self.icon and (" " .. self.icon .. " ")
  end,
  hl = function(self)
    return { fg = self.icon_color, bg = colors.bg_elev1 }
  end,
}

-- FILE NAME
local FileName = {
  provider = function()
    local name = vim.fn.expand("%:t")
    if name == "" then
      return "[No Name] "
    end
    return name .. " "
  end,
  hl = { fg = colors.fg, bg = colors.bg_elev1 },
}

-- GIT
local Git = {
  condition = conditions.is_git_repo,

  init = function(self)
    self.status_dict = vim.b.gitsigns_status_dict
  end,

  hl = { bg = colors.bg_elev1 },

  {
    provider = function(self)
      return " " .. (self.status_dict.head or "") .. " "
    end,
    hl = { fg = colors.accent },
  },

  {
    provider = function(self)
      local s = self.status_dict
      return string.format("+%s ~%s -%s ", s.added or 0, s.changed or 0, s.removed or 0)
    end,
    hl = { fg = colors.accent2 },
  },
}

-- LSP DIAGNOSTICS
local Diagnostics = {
  condition = conditions.has_diagnostics,
  hl = { bg = colors.bg_elev1 },

  {
    provider = function()
      local n = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
      return n > 0 and (" " .. n .. " ") or ""
    end,
    hl = { fg = colors.error },
  },

  {
    provider = function()
      local n = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
      return n > 0 and (" " .. n .. " ") or ""
    end,
    hl = { fg = colors.warn },
  },

  {
    provider = function()
      local n = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
      return n > 0 and (" " .. n .. " ") or ""
    end,
    hl = { fg = colors.info },
  },
}

-- POSITION
local Position = {
  provider = "%l:%c ",
  hl = { fg = colors.accent, bg = colors.bg_elev1 },
}

-- PERCENT
local Percent = {
  provider = "%p%%",
  hl = { fg = colors.accent2, bg = colors.bg_elev1 },
}

-- MODE BLOCK
local Mode = {
  provider = function()
    return "  " .. vim.fn.mode():upper() .. " "
  end,
  hl = mode_hl,
}

-- FULL STATUSLINE
heirline.setup({
  statusline = {
    Mode,
    FileIcon,
    FileName,
    Git,
    Diagnostics,

    { provider = "%=" },

    Position,
    Percent,
  },
})

