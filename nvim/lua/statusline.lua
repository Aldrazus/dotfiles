local M = {}

local mode_names = {
  n = "NORMAL",
  no = "OP-PENDING",
  nov = "OP-PENDING",
  noV = "OP-PENDING",
  ["no\22"] = "OP-PENDING",
  niI = "NORMAL",
  niR = "NORMAL",
  niV = "NORMAL",
  nt = "NORMAL",
  ntT = "NORMAL",
  v = "VISUAL",
  vs = "VISUAL",
  V = "V-LINE",
  Vs = "V-LINE",
  ["\22"] = "V-BLOCK",
  ["\22s"] = "V-BLOCK",
  s = "SELECT",
  S = "S-LINE",
  ["\19"] = "S-BLOCK",
  i = "INSERT",
  ic = "INSERT",
  ix = "INSERT",
  R = "REPLACE",
  Rc = "REPLACE",
  Rx = "REPLACE",
  Rv = "V-REPLACE",
  Rvc = "V-REPLACE",
  Rvx = "V-REPLACE",
  c = "COMMAND",
  cv = "EX",
  ce = "EX",
  r = "PROMPT",
  rm = "MORE",
  ["r?"] = "CONFIRM",
  ["!"] = "SHELL",
  t = "TERMINAL",
}

local mode_highlights = {
  n = "StatusLineModeNormal",
  no = "StatusLineModeNormal",
  nov = "StatusLineModeNormal",
  noV = "StatusLineModeNormal",
  ["no\22"] = "StatusLineModeNormal",
  niI = "StatusLineModeNormal",
  niR = "StatusLineModeNormal",
  niV = "StatusLineModeNormal",
  nt = "StatusLineModeNormal",
  ntT = "StatusLineModeNormal",
  i = "StatusLineModeInsert",
  ic = "StatusLineModeInsert",
  ix = "StatusLineModeInsert",
  v = "StatusLineModeVisual",
  vs = "StatusLineModeVisual",
  V = "StatusLineModeVisual",
  Vs = "StatusLineModeVisual",
  ["\22"] = "StatusLineModeVisual",
  ["\22s"] = "StatusLineModeVisual",
  s = "StatusLineModeVisual",
  S = "StatusLineModeVisual",
  ["\19"] = "StatusLineModeVisual",
  R = "StatusLineModeReplace",
  Rc = "StatusLineModeReplace",
  Rx = "StatusLineModeReplace",
  Rv = "StatusLineModeReplace",
  Rvc = "StatusLineModeReplace",
  Rvx = "StatusLineModeReplace",
  c = "StatusLineModeCommand",
  cv = "StatusLineModeCommand",
  ce = "StatusLineModeCommand",
  t = "StatusLineModeTerminal",
}

local function diagnostics()
  local counts = vim.diagnostic.count(0)
  local parts = {}

  local severities = {
    { vim.diagnostic.severity.ERROR, "StatusLineDiagError", "E" },
    { vim.diagnostic.severity.WARN, "StatusLineDiagWarn", "W" },
    { vim.diagnostic.severity.INFO, "StatusLineDiagInfo", "I" },
    { vim.diagnostic.severity.HINT, "StatusLineDiagHint", "H" },
  }

  for _, item in ipairs(severities) do
    local count = counts[item[1]]
    if count and count > 0 then
      table.insert(parts, "%#" .. item[2] .. "#" .. item[3] .. count)
    end
  end

  return table.concat(parts, "%#StatusLine# ")
end

local function set_highlights()
  local colors = {
    bg = "#1e1e2e",
    fg = "#cdd6f4",
    surface = "#313244",
    muted = "#6c7086",
    blue = "#89b4fa",
    green = "#a6e3a1",
    mauve = "#cba6f7",
    red = "#f38ba8",
    yellow = "#f9e2af",
    peach = "#fab387",
    teal = "#94e2d5",
    lavender = "#b4befe",
  }

  vim.api.nvim_set_hl(0, "StatusLine", { fg = colors.fg, bg = colors.bg })
  vim.api.nvim_set_hl(0, "StatusLineNC", { fg = colors.muted, bg = colors.bg })
  vim.api.nvim_set_hl(0, "StatusLineModeNormal", { fg = colors.bg, bg = colors.blue, bold = true })
  vim.api.nvim_set_hl(0, "StatusLineModeInsert", { fg = colors.bg, bg = colors.green, bold = true })
  vim.api.nvim_set_hl(0, "StatusLineModeVisual", { fg = colors.bg, bg = colors.mauve, bold = true })
  vim.api.nvim_set_hl(0, "StatusLineModeReplace", { fg = colors.bg, bg = colors.red, bold = true })
  vim.api.nvim_set_hl(0, "StatusLineModeCommand", { fg = colors.bg, bg = colors.peach, bold = true })
  vim.api.nvim_set_hl(0, "StatusLineModeTerminal", { fg = colors.bg, bg = colors.teal, bold = true })
  vim.api.nvim_set_hl(0, "StatusLineBranch", { fg = colors.green, bg = colors.bg, bold = true })
  vim.api.nvim_set_hl(0, "StatusLineFile", { fg = colors.fg, bg = colors.bg, bold = true })
  vim.api.nvim_set_hl(0, "StatusLineMuted", { fg = colors.muted, bg = colors.bg })
  vim.api.nvim_set_hl(0, "StatusLineFiletype", { fg = colors.lavender, bg = colors.bg, bold = true })
  vim.api.nvim_set_hl(0, "StatusLinePosition", { fg = colors.bg, bg = colors.lavender, bold = true })
  vim.api.nvim_set_hl(0, "StatusLineDiagError", { fg = colors.red, bg = colors.bg, bold = true })
  vim.api.nvim_set_hl(0, "StatusLineDiagWarn", { fg = colors.yellow, bg = colors.bg, bold = true })
  vim.api.nvim_set_hl(0, "StatusLineDiagInfo", { fg = colors.blue, bg = colors.bg, bold = true })
  vim.api.nvim_set_hl(0, "StatusLineDiagHint", { fg = colors.teal, bg = colors.bg, bold = true })
end

function M.statusline()
  local mode_code = vim.api.nvim_get_mode().mode
  local mode = mode_names[mode_code] or "?"
  local mode_hl = mode_highlights[mode_code] or "StatusLineModeNormal"
  local branch = vim.b.gitsigns_head
  local diag = diagnostics()
  local filetype = vim.bo.filetype

  local parts = {
    "%#" .. mode_hl .. "# ",
    mode,
    " %#StatusLine#",
    branch and branch ~= "" and (" %#StatusLineBranch# " .. branch) or "",
    " %#StatusLineFile#%f",
    "%#StatusLineDiagWarn#%m",
    "%#StatusLineMuted#%r",
    diag ~= "" and ("  " .. diag) or "",
    "%=",
    filetype ~= "" and ("%#StatusLineFiletype#" .. filetype .. " ") or "",
    "%#StatusLinePosition# %p%%  %l:%c ",
  }

  return table.concat(parts)
end

function M.setup()
  set_highlights()

  vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup("statusline.highlights", { clear = true }),
    callback = set_highlights,
  })

  vim.o.statusline = "%!v:lua.require'statusline'.statusline()"
end

return M
