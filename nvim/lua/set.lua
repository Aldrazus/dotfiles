local function is_windows()
  return package.config:sub(1, 1) == "\\"
end

local function get_home_dir()
  if is_windows() then
    local drive = os.getenv("HOMEDRIVE") or "C:"
    return drive .. (os.getenv("HOMEPATH") or "\\")
  end

  return os.getenv("HOME") or "."
end

vim.opt.fileencoding = "UTF-8"
vim.opt.encoding = "UTF-8"

vim.opt.showmode = false
vim.opt.relativenumber = true
vim.opt.nu = true
vim.opt.hidden = true
vim.opt.errorbells = false

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = get_home_dir() .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.completeopt = "menuone,noinsert,noselect"
vim.opt.signcolumn = "yes"
vim.opt.cmdheight = 2
vim.opt.updatetime = 50
vim.opt.mouse = "a"
vim.opt.showtabline = 1
vim.opt.inccommand = "split"
vim.opt.shortmess:append("c")
vim.opt.keywordprg = ":help"
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99
vim.opt.foldnestmax = 8
vim.opt.foldcolumn = "0"
vim.opt.shell = "pwsh"
vim.o.winborder = "rounded"

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.cmd("syntax on")

-- Set filetype for shaders
vim.filetype.add({
  extension = {
    vert = "glsl",
    frag = "glsl",
    vsh = "glsl",
    fsh = "glsl",
  },
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.vert", "*.frag", "*.vsh", "*.fsh" },
  command = "setfiletype glsl",
})

if vim.fn.executable("rg") == 1 then
  vim.opt.grepprg = "rg --vimgrep --no-heading --smart-case"
end

vim.api.nvim_create_autocmd("BufReadPost", {
  desc = "Open files at the last known cursor position",
  group = vim.api.nvim_create_augroup("last_position_restore", { clear = true }),
  command = 'silent! normal! g`"zv',
})
