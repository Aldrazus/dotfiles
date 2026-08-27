local M = {}

local ns = vim.api.nvim_create_namespace("termnav")
local highlight_group = "TermnavLocation"
local git_root_cache = {}

local trailing = "[,;:%.%)%]%}>]"
local leading = "[(%[%{%<'\"`]"

local function trim_token(token)
  token = token:gsub("^" .. leading .. "+", "")
  token = token:gsub(trailing .. "+$", "")
  return token
end

local function expand_path(path)
  if path:sub(1, 7) == "file://" then
    path = path:sub(8)
    path = vim.fn.fnamemodify(path, ":p")
  elseif path:sub(1, 1) == "~" then
    path = vim.fn.expand(path)
  end

  return path
end

local function is_url(text)
  return text:match("^https?://") ~= nil
end

local function path_exists(path)
  return vim.uv.fs_stat(path) ~= nil
end

local function git_root()
  local cwd = vim.fn.getcwd()
  if git_root_cache[cwd] ~= nil then
    return git_root_cache[cwd] or nil
  end

  local root = vim.fs.root(cwd, { ".git" })
  if not root then
    local out = vim.fn.systemlist({ "git", "rev-parse", "--show-toplevel" })
    if vim.v.shell_error == 0 and out[1] and out[1] ~= "" then
      root = out[1]
    end
  end

  git_root_cache[cwd] = root or false
  return root
end

local function resolve_path(path)
  path = expand_path(path)

  if vim.fn.fnamemodify(path, ":p") == path and path_exists(path) then
    return path
  end

  if path_exists(path) then
    return vim.fn.fnamemodify(path, ":p")
  end

  local cwd_path = vim.fs.normalize(vim.fn.getcwd() .. "/" .. path)
  if path_exists(cwd_path) then
    return cwd_path
  end

  local root = git_root()
  if root then
    local root_path = vim.fs.normalize(root .. "/" .. path)
    if path_exists(root_path) then
      return root_path
    end
  end
end

local function split_location(token)
  local path, line, col = token:match("^(.-):(%d+):(%d+)$")
  if path and path ~= "" then
    return path, tonumber(line), tonumber(col)
  end

  path, line = token:match("^(.-):(%d+)$")
  if path and path ~= "" then
    return path, tonumber(line), nil
  end

  return token, nil, nil
end

local function parse_token(token)
  token = trim_token(token)

  if token == "" then
    return nil
  end

  if is_url(token) then
    return { url = token }
  end

  local path, line, col = split_location(token)
  local resolved = resolve_path(path)
  if not resolved then
    return nil
  end

  return {
    path = resolved,
    line = line or 1,
    col = col or 1,
  }
end

local function token_at(line, col)
  local start_col = col
  local end_col = col

  while start_col > 1 and not line:sub(start_col - 1, start_col - 1):match("%s") do
    start_col = start_col - 1
  end

  while end_col <= #line and not line:sub(end_col, end_col):match("%s") do
    end_col = end_col + 1
  end

  return line:sub(start_col, end_col - 1)
end

local function visible_ranges(buf)
  local ranges = {}

  for _, win in ipairs(vim.fn.win_findbuf(buf)) do
    if vim.api.nvim_win_is_valid(win) then
      local top = vim.api.nvim_win_call(win, function()
        return vim.fn.line("w0")
      end)
      local bottom = vim.api.nvim_win_call(win, function()
        return vim.fn.line("w$")
      end)

      table.insert(ranges, { top, bottom })
    end
  end

  if #ranges == 0 then
    local last = vim.api.nvim_buf_line_count(buf)
    table.insert(ranges, { math.max(last - 200, 1), last })
  end

  return ranges
end

local function highlight_range(buf, first, last)
  vim.api.nvim_buf_clear_namespace(buf, ns, first - 1, last)

  local lines = vim.api.nvim_buf_get_lines(buf, first - 1, last, false)
  for row, line in ipairs(lines) do
    for start_col, token in line:gmatch("()(%S+)") do
      local end_col = start_col + #token - 1

      if parse_token(token) then
        vim.api.nvim_buf_set_extmark(buf, ns, first + row - 2, start_col - 1, {
          end_col = end_col,
          hl_group = highlight_group,
          priority = 110,
        })
      end
    end
  end
end

local function editor_window()
  local previous = vim.fn.win_getid(vim.fn.winnr("#"))
  if previous ~= 0 and vim.api.nvim_win_is_valid(previous) then
    local buf = vim.api.nvim_win_get_buf(previous)
    if vim.bo[buf].buftype ~= "terminal" then
      return previous
    end
  end

  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.bo[buf].buftype ~= "terminal" then
      return win
    end
  end
end

local function open_location(location)
  if location.url then
    vim.ui.open(location.url)
    return true
  end

  local win = editor_window()
  if win then
    vim.api.nvim_set_current_win(win)
  else
    vim.cmd.split()
  end

  vim.cmd.edit(vim.fn.fnameescape(location.path))
  vim.api.nvim_win_set_cursor(0, { location.line, math.max(location.col - 1, 0) })
  vim.cmd("normal! zvzz")
  return true
end

function M.open_under_cursor()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local line = vim.api.nvim_get_current_line()
  local token = token_at(line, cursor[2] + 1)
  local location = parse_token(token)

  if not location then
    vim.notify("No file location under cursor", vim.log.levels.WARN)
    return false
  end

  return open_location(location)
end

function M.open_at_mouse()
  local mouse = vim.fn.getmousepos()
  if mouse.winid == 0 or not vim.api.nvim_win_is_valid(mouse.winid) then
    return false
  end

  vim.api.nvim_set_current_win(mouse.winid)
  vim.api.nvim_win_set_cursor(mouse.winid, { mouse.line, math.max(mouse.column - 1, 0) })
  return M.open_under_cursor()
end

function M.highlight(buf)
  if not vim.api.nvim_buf_is_valid(buf) then
    return
  end

  for _, range in ipairs(visible_ranges(buf)) do
    highlight_range(buf, range[1], range[2])
  end
end

function M.attach(buf)
  local opts = { buffer = buf, silent = true }

  vim.keymap.set("n", "gf", M.open_under_cursor, vim.tbl_extend("force", opts, {
    desc = "Open terminal file location",
  }))
  vim.keymap.set("n", "gF", M.open_under_cursor, vim.tbl_extend("force", opts, {
    desc = "Open terminal file location",
  }))
  vim.keymap.set("n", "<CR>", M.open_under_cursor, vim.tbl_extend("force", opts, {
    desc = "Open terminal file location",
  }))
  vim.keymap.set({ "n", "t" }, "<C-LeftMouse>", M.open_at_mouse, vim.tbl_extend("force", opts, {
    desc = "Open terminal file location",
  }))

  vim.schedule(function()
    M.highlight(buf)
  end)
end

function M.setup()
  vim.api.nvim_set_hl(0, highlight_group, { link = "Underlined", default = true })

  local group = vim.api.nvim_create_augroup("termnav", { clear = true })

  vim.api.nvim_create_autocmd("TermOpen", {
    group = group,
    desc = "Enable file location navigation in terminal buffers",
    callback = function(args)
      M.attach(args.buf)
    end,
  })

  vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedT", "BufEnter", "TermEnter" }, {
    group = group,
    desc = "Highlight file locations in terminal buffers",
    callback = function(args)
      if vim.bo[args.buf].buftype == "terminal" then
        M.highlight(args.buf)
      end
    end,
  })

  vim.api.nvim_create_autocmd("WinScrolled", {
    group = group,
    desc = "Refresh terminal file location highlights after scrolling",
    callback = function()
      local buf = vim.api.nvim_get_current_buf()
      if vim.bo[buf].buftype == "terminal" then
        M.highlight(buf)
      end
    end,
  })
end

return M
