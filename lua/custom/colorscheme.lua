local M = {}

M.base = {
  bg           = "#080908", -- Deep CRT black
  bg_elev1     = "#0e100e", -- Floating windows / statusline
  bg_elev2     = "#141814", -- Selection / hover / pmenu sel
  border       = "#1f291f", -- Inactive split border
  border_hi    = "#00ff66", -- Active float / Hyprland border

  fg           = "#dfe6dc", -- Crisp warm off-white
  fg_dim       = "#8d998a", -- Secondary identifiers / brackets
  muted        = "#535e50", -- Comments / line numbers

  phosphor     = "#00ff66", -- Functions, active UI, cursor (matches Hyprland)
  phosphor_mid = "#26c947", -- Keywords, control flow, imports (pure medium green)
  phosphor_dim = "#143318", -- Visual selection / search match fill
  lime         = "#9eff3d", -- Strings (warm CRT lime-green, zero blue)
  mint         = "#9eff3d", -- Strings & file paths
  emerald      = "#4ce645", -- Types, classes, interfaces (pure grass/CRT green)
  teal         = "#c8e64c", -- Properties, struct fields, object keys (yellow-green)
  amber        = "#e5c07b", -- Warnings, parameters, constants/numbers
  red          = "#ff5555", -- Errors, deleted git lines
}

function M.apply()
  vim.cmd("hi clear")
  if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
  end

  vim.o.termguicolors = true
  vim.o.background = "dark"
  vim.g.colors_name = "terminal_phosphor"

  local c = M.base
  local hl = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  -- =========================================================================
  -- 1. CORE EDITOR UI & SHARP TUI BORDERS
  -- =========================================================================
  hl("Normal",          { fg = c.fg, bg = c.bg })
  hl("NormalNC",        { fg = c.fg_dim, bg = c.bg })
  hl("NormalFloat",     { fg = c.fg, bg = c.bg_elev1 })
  hl("FloatBorder",     { fg = c.border_hi, bg = c.bg_elev1 })
  hl("FloatTitle",      { fg = c.bg, bg = c.phosphor, bold = true })
  hl("WinSeparator",    { fg = c.border, bg = c.bg })
  hl("VertSplit",       { link = "WinSeparator" })
  hl("EndOfBuffer",     { fg = c.bg, bg = c.bg })

  hl("Cursor",          { fg = c.bg, bg = c.phosphor })
  hl("CursorLine",      { bg = c.bg_elev1 })
  hl("CursorColumn",    { bg = c.bg_elev1 })
  hl("ColorColumn",     { bg = c.bg_elev1 })
  hl("LineNr",          { fg = c.muted, bg = c.bg })
  hl("CursorLineNr",    { fg = c.phosphor, bg = c.bg_elev1, bold = true })
  hl("SignColumn",      { fg = c.muted, bg = c.bg })
  hl("FoldColumn",      { fg = c.muted, bg = c.bg })
  hl("Folded",          { fg = c.fg_dim, bg = c.bg_elev1, italic = true })

  hl("Visual",          { bg = c.phosphor_dim })
  hl("VisualNOS",       { bg = c.phosphor_dim })
  hl("Search",          { fg = c.bg, bg = c.phosphor_mid, bold = true })
  hl("IncSearch",       { fg = c.bg, bg = c.phosphor, bold = true })
  hl("CurSearch",       { link = "IncSearch" })
  hl("Substitute",      { fg = c.bg, bg = c.amber, bold = true })
  hl("MatchParen",      { fg = c.phosphor, bg = c.phosphor_dim, bold = true, underline = true })

  hl("StatusLine",      { fg = c.fg, bg = c.bg_elev1 })
  hl("StatusLineNC",    { fg = c.muted, bg = c.bg_elev1 })
  hl("TabLine",         { fg = c.muted, bg = c.bg_elev1 })
  hl("TabLineFill",     { bg = c.bg })
  hl("TabLineSel",      { fg = c.bg, bg = c.phosphor, bold = true })
  hl("WinBar",          { fg = c.fg_dim, bg = c.bg })
  hl("WinBarNC",        { fg = c.muted, bg = c.bg })

  hl("Pmenu",           { fg = c.fg, bg = c.bg_elev1 })
  hl("PmenuSel",        { fg = c.bg, bg = c.phosphor, bold = true })
  hl("PmenuSbar",       { bg = c.bg_elev1 })
  hl("PmenuThumb",      { bg = c.phosphor_mid })
  hl("WildMenu",        { link = "PmenuSel" })

  hl("Directory",       { fg = c.phosphor, bold = true })
  hl("Title",           { fg = c.phosphor, bold = true })
  hl("Question",        { fg = c.phosphor })
  hl("MoreMsg",         { fg = c.mint })
  hl("ModeMsg",         { fg = c.phosphor, bold = true })
  hl("ErrorMsg",        { fg = c.red, bold = true })
  hl("WarningMsg",      { fg = c.amber, bold = true })
  hl("NonText",         { fg = "#1e2621" })
  hl("Whitespace",      { fg = "#1e2621" })
  hl("SpecialKey",      { fg = c.muted })

  -- =========================================================================
  -- 2. STANDARD VIM SYNTAX GROUPS
  -- =========================================================================
  hl("Comment",         { fg = c.muted, italic = true })
  hl("Constant",        { fg = c.lime })
  hl("String",          { fg = c.mint })
  hl("Character",       { fg = c.mint })
  hl("Number",          { fg = c.lime })
  hl("Boolean",         { fg = c.lime, bold = true })
  hl("Float",           { fg = c.lime })

  hl("Identifier",      { fg = c.fg })
  hl("Function",        { fg = c.phosphor, bold = true })

  hl("Statement",       { fg = c.phosphor_mid, bold = true })
  hl("Conditional",     { fg = c.phosphor_mid, bold = true })
  hl("Repeat",          { fg = c.phosphor_mid, bold = true })
  hl("Label",           { fg = c.phosphor_mid })
  hl("Operator",        { fg = c.phosphor_mid })
  hl("Keyword",         { fg = c.phosphor_mid, bold = true })
  hl("Exception",       { fg = c.red, bold = true })

  hl("PreProc",         { fg = c.phosphor_mid })
  hl("Include",         { fg = c.phosphor_mid, bold = true })
  hl("Define",          { fg = c.phosphor_mid })
  hl("Macro",           { fg = c.teal })
  hl("PreCondit",       { fg = c.phosphor_mid })

  hl("Type",            { fg = c.emerald })
  hl("StorageClass",    { fg = c.phosphor_mid })
  hl("Structure",       { fg = c.emerald })
  hl("Typedef",         { fg = c.emerald })

  hl("Special",         { fg = c.amber })
  hl("SpecialChar",     { fg = c.amber })
  hl("Tag",             { fg = c.phosphor })
  hl("Delimiter",       { fg = c.fg_dim })
  hl("SpecialComment",  { fg = c.mint, italic = true })
  hl("Debug",           { fg = c.red })

  hl("Underlined",      { underline = true })
  hl("Error",           { fg = c.red, bold = true })
  hl("Todo",            { fg = c.bg, bg = c.amber, bold = true })

  -- =========================================================================
  -- 3. TREESITTER (@) CAPTURE GROUPS (Python, TS/React, C#, Lua, HTML/CSS)
  -- =========================================================================
  hl("@comment",                 { link = "Comment" })
  hl("@comment.todo",            { link = "Todo" })
  hl("@comment.warning",         { fg = c.bg, bg = c.amber, bold = true })
  hl("@comment.error",           { fg = c.bg, bg = c.red, bold = true })

  hl("@string",                  { link = "String" })
  hl("@string.escape",           { fg = c.amber, bold = true })
  hl("@string.regexp",           { fg = c.amber })
  hl("@string.special.url",      { fg = c.teal, underline = true })
  hl("@character",               { link = "Character" })
  hl("@number",                  { link = "Number" })
  hl("@boolean",                 { link = "Boolean" })

  hl("@constant",                { link = "Constant" })
  hl("@constant.builtin",        { fg = c.lime, bold = true })
  hl("@constant.macro",          { fg = c.lime })

  hl("@variable",                { fg = c.fg })
  hl("@variable.builtin",        { fg = c.emerald, italic = true }) -- self, this, cls
  hl("@variable.parameter",      { fg = c.amber })
  hl("@variable.member",         { fg = c.teal })

  hl("@property",                { fg = c.teal })
  hl("@attribute",               { fg = c.amber }) -- Python @decorators, C# [Attributes]
  hl("@module",                  { fg = c.emerald })
  hl("@module.builtin",          { fg = c.emerald, italic = true })

  hl("@function",                { fg = c.phosphor, bold = true })
  hl("@function.call",           { fg = c.phosphor })
  hl("@function.method",         { fg = c.phosphor, bold = true })
  hl("@function.method.call",    { fg = c.phosphor })
  hl("@function.builtin",        { fg = c.teal })
  hl("@constructor",             { fg = c.emerald, bold = true })

  hl("@keyword",                 { fg = c.phosphor_mid, bold = true })
  hl("@keyword.import",          { fg = c.phosphor_mid, bold = true })
  hl("@keyword.function",        { fg = c.phosphor_mid, bold = true })
  hl("@keyword.return",          { fg = c.phosphor_mid, bold = true })
  hl("@keyword.operator",        { fg = c.phosphor_mid })
  hl("@keyword.conditional",     { fg = c.phosphor_mid, bold = true })
  hl("@keyword.repeat",          { fg = c.phosphor_mid, bold = true })
  hl("@keyword.exception",       { fg = c.red, bold = true })
  hl("@operator",                { fg = c.phosphor_mid })

  hl("@type",                    { fg = c.emerald })
  hl("@type.builtin",            { fg = c.emerald, italic = true })
  hl("@type.definition",         { fg = c.emerald, bold = true })

  hl("@punctuation.delimiter",   { fg = c.fg_dim })
  hl("@punctuation.bracket",     { fg = c.fg_dim })
  hl("@punctuation.special",     { fg = c.amber }) -- f-string {} / JSX {}

  -- JSX / TSX / HTML
  hl("@tag",                     { fg = c.phosphor })
  hl("@tag.builtin",             { fg = c.phosphor_mid })
  hl("@tag.attribute",           { fg = c.teal })
  hl("@tag.delimiter",           { fg = c.muted })

  -- =========================================================================
  -- 4. LSP SEMANTIC TOKENS & DIAGNOSTICS
  -- =========================================================================
  hl("@lsp.type.class",          { link = "@type" })
  hl("@lsp.type.struct",         { link = "@type" })
  hl("@lsp.type.interface",      { fg = c.emerald, italic = true })
  hl("@lsp.type.enum",           { link = "@type" })
  hl("@lsp.type.enumMember",     { link = "@constant" })
  hl("@lsp.type.function",       { link = "@function" })
  hl("@lsp.type.method",         { link = "@function.method" })
  hl("@lsp.type.parameter",      { link = "@variable.parameter" })
  hl("@lsp.type.property",       { link = "@property" })
  hl("@lsp.type.variable",       { link = "@variable" })
  hl("@lsp.type.namespace",      { link = "@module" })

  hl("DiagnosticError",          { fg = c.red })
  hl("DiagnosticWarn",           { fg = c.amber })
  hl("DiagnosticInfo",           { fg = c.phosphor })
  hl("DiagnosticHint",           { fg = c.teal })
  hl("DiagnosticUnderlineError", { undercurl = true, sp = c.red })
  hl("DiagnosticUnderlineWarn",  { undercurl = true, sp = c.amber })
  hl("DiagnosticUnderlineInfo",  { undercurl = true, sp = c.phosphor })
  hl("DiagnosticUnderlineHint",  { undercurl = true, sp = c.teal })

  -- =========================================================================
  -- 5. GIT & DIFFS
  -- =========================================================================
  hl("DiffAdd",                  { bg = "#0f2918" })
  hl("DiffChange",               { bg = "#14241c" })
  hl("DiffDelete",               { fg = c.red, bg = "#261010" })
  hl("DiffText",                 { bg = "#1c3d29", bold = true })
  hl("GitSignsAdd",              { fg = c.phosphor, bg = c.bg })
  hl("GitSignsChange",           { fg = c.amber, bg = c.bg })
  hl("GitSignsDelete",           { fg = c.red, bg = c.bg })

  -- =========================================================================
  -- 6. PLUGINS (Telescope, Completion Menus, Indent Guides, Which-Key)
  -- =========================================================================
  hl("TelescopeNormal",          { fg = c.fg, bg = c.bg_elev1 })
  hl("TelescopeBorder",          { fg = c.border_hi, bg = c.bg_elev1 })
  hl("TelescopePromptNormal",    { fg = c.fg, bg = c.bg_elev2 })
  hl("TelescopePromptBorder",    { fg = c.border_hi, bg = c.bg_elev2 })
  hl("TelescopePromptTitle",     { fg = c.bg, bg = c.phosphor, bold = true })
  hl("TelescopePreviewTitle",    { fg = c.bg, bg = c.phosphor_mid, bold = true })
  hl("TelescopeResultsTitle",    { fg = c.bg, bg = c.emerald, bold = true })
  hl("TelescopeSelection",       { fg = c.phosphor, bg = c.bg_elev2, bold = true })
  hl("TelescopeMatching",        { fg = c.lime, bold = true })

  hl("CmpItemAbbrMatch",         { fg = c.phosphor, bold = true })
  hl("CmpItemAbbrMatchFuzzy",    { fg = c.phosphor, bold = true })
  hl("CmpItemKindFunction",      { fg = c.phosphor })
  hl("CmpItemKindMethod",        { fg = c.phosphor })
  hl("CmpItemKindVariable",      { fg = c.fg })
  hl("CmpItemKindKeyword",       { fg = c.phosphor_mid })
  hl("CmpItemKindClass",         { fg = c.emerald })
  hl("CmpItemKindProperty",      { fg = c.teal })
  hl("BlinkCmpMenu",             { link = "Pmenu" })
  hl("BlinkCmpMenuBorder",       { link = "FloatBorder" })
  hl("BlinkCmpMenuSelection",    { link = "PmenuSel" })

  hl("IblIndent",                { fg = "#161d19" })
  hl("IblScope",                 { fg = "#2a4736" })
  hl("WhichKey",                 { fg = c.phosphor, bold = true })
  hl("WhichKeyGroup",            { fg = c.emerald })
  hl("WhichKeyDesc",             { fg = c.fg_dim })
  hl("WhichKeyBorder",           { link = "FloatBorder" })

  -- =========================================================================
  -- 7. BUILT-IN TERMINAL ANSI COLORS (:terminal)
  -- =========================================================================
  vim.g.terminal_color_0  = c.bg
  vim.g.terminal_color_1  = c.red
  vim.g.terminal_color_2  = c.phosphor
  vim.g.terminal_color_3  = c.amber
  vim.g.terminal_color_4  = c.emerald
  vim.g.terminal_color_5  = c.teal
  vim.g.terminal_color_6  = c.mint
  vim.g.terminal_color_7  = c.fg
  vim.g.terminal_color_8  = c.muted
  vim.g.terminal_color_9  = c.red
  vim.g.terminal_color_10 = c.lime
  vim.g.terminal_color_11 = c.amber
  vim.g.terminal_color_12 = c.emerald
  vim.g.terminal_color_13 = c.teal
  vim.g.terminal_color_14 = c.mint
  vim.g.terminal_color_15 = "#ffffff"
end

return M