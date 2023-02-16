" Plug: {{{
" The following line is already done by plug vim
" filetype plugin indent on

" Install vim plug and plugins if vim plug is not already installed
" if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
"    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
"                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
" endif

call plug#begin()

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'joshdick/onedark.vim'
Plug 'tpope/vim-fugitive'

" Cool stuff
Plug 'itchyny/lightline.vim'
Plug 'andymass/vim-matchup'

" LSP stuff
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp', {'branch': 'main'}
Plug 'hrsh7th/cmp-buffer', {'branch': 'main'}
Plug 'hrsh7th/cmp-path', {'branch': 'main'}
Plug 'hrsh7th/nvim-cmp', {'branch': 'main'}
Plug 'ray-x/lsp_signature.nvim'

Plug 'hrsh7th/cmp-vsnip', {'branch': 'main'}
Plug 'hrsh7th/vim-vsnip'

Plug 'simrat39/rust-tools.nvim'

call plug#end()
" }}}

" Options: {{{
colorscheme onedark
nnoremap <SPACE> <Nop>
let mapleader=" "
set fileencoding=UTF-8
set encoding=UTF-8
set background=dark
set noshowmode
syntax on
set relativenumber
set nu
set nohlsearch
set hidden
set noerrorbells
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab smarttab
set expandtab
set smartindent
set nowrap
set noswapfile
set nobackup
set nowritebackup
set backupcopy=yes
set undodir=~/.vim/undodir
set undofile
set incsearch
set termguicolors
set scrolloff=8
set completeopt=menuone,noinsert,noselect
set signcolumn=yes
set cmdheight=2
set updatetime=300
set mouse=a
highlight Comment cterm=italic gui=italic

if has("nvim-0.5.0") || has("patch-8.1.1564")
    set signcolumn=number
else
    set signcolumn=yes
endif

set showtabline=1
set inccommand=split
set cmdheight=2
set shortmess+=c
set guioptions-=T " remove toolbar
autocmd InsertEnter * set cul
autocmd InsertLeave * set nocul

" Support for comments in json
" Treating json files as jsonc doesn't result in nice syntax highlighting...
" So just add // and /* */ to Comment group
autocmd FileType json syntax match Comment +\/\/.\+$+
autocmd FileType json syntax match Comment +\/\*.\+\*\/$+

highlight Normal guibg=none
" }}}

" Mappings for Telescope
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Lightline config
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileencoding', 'filetype' ] ],
      \ },
      \ 'component_function': {
      \   'filename': 'LightlineFilename'
      \ },
      \ }
function! LightlineFilename()
  return expand('%:t') !=# '' ? @% : '[No Name]'
endfunction

" rip my grep a new one
" God bless this person: https://github.com/BurntSushi/ripgrep/issues/425#issuecomment-381446152
set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
nnoremap <Leader>rg :silent lgrep<Space>
nnoremap <silent> [f :lprevious<CR>
nnoremap <silent> ]f :lnext<CR>

" netrw
let g:netrw_banner = 0
let g:netrw_list_hide = '^\.\.\?/$'
let g:netrw_liststyle = 0
let g:netrw_sort_sequence = '[\/]$'
let g:netrw_use_errorwindow = 0



" =============================================================================


" Lua bullshit
" TODO: move to separate file
lua << EOF
-- Configure Treesitter
require('nvim-treesitter.configs').setup {
  ensure_installed = { "javascript", "typescript", "rust", "json", "haskell", "help", "comment", "vim", "lua" },
  highlight = { 
      enable = true,
  },
}

-- Configure cmp
local function on_attach(client, buffer)
  -- This callback is called when the LSP is atttached/enabled for this buffer
  -- we could set keymaps related to LSP, etc here.
  local keymap_opts = { buffer = buffer }
  -- Code navigation and shortcuts
  vim.keymap.set("n", "<c-]>", vim.lsp.buf.definition, keymap_opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, keymap_opts)
  vim.keymap.set("n", "gD", vim.lsp.buf.implementation, keymap_opts)
  vim.keymap.set("n", "<c-k>", vim.lsp.buf.signature_help, keymap_opts)
  vim.keymap.set("n", "1gD", vim.lsp.buf.type_definition, keymap_opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, keymap_opts)
  vim.keymap.set("n", "g0", vim.lsp.buf.document_symbol, keymap_opts)
  vim.keymap.set("n", "gW", vim.lsp.buf.workspace_symbol, keymap_opts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, keymap_opts)

  vim.keymap.set("n", "ga", vim.lsp.buf.code_action, keymap_opts)

  -- Set updatetime for CursorHold
  -- 300ms of no cursor movement to trigger CursorHold
  vim.opt.updatetime = 100

  -- Show diagnostic popup on cursor hover
  local diag_float_grp = vim.api.nvim_create_augroup("DiagnosticFloat", { clear = true })
  vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
     vim.diagnostic.open_float(nil, { focusable = false })
    end,
    group = diag_float_grp,
  })

  -- Goto previous/next diagnostic warning/error
  vim.keymap.set("n", "g[", vim.diagnostic.goto_prev, keymap_opts)
  vim.keymap.set("n", "g]", vim.diagnostic.goto_next, keymap_opts)
end

-- Configure LSP through rust-tools.nvim plugin.
-- rust-tools will configure and enable certain LSP features for us.
-- See https://github.com/simrat39/rust-tools.nvim#configuration
local opts = {
  tools = {
    inlay_hints = {
      auto = true,
      show_parameter_hints = false,
      parameter_hints_prefix = "",
      other_hints_prefix = "",
    },
  },

  -- all the opts to send to nvim-lspconfig
  -- these override the defaults set by rust-tools.nvim
  -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
  server = {
    -- on_attach is a callback called when the language server attachs to the buffer
    on_attach = on_attach,
    settings = {
      -- to enable rust-analyzer settings visit:
      -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
      ["rust-analyzer"] = {
        -- enable clippy on save
        checkOnSave = {
          command = "clippy",
        },
      },
    },
  },
}

require("rust-tools").setup(opts)

-- Setup Completion
-- See https://github.com/hrsh7th/nvim-cmp#basic-configuration
local cmp = require("cmp")
cmp.setup({
  preselect = cmp.PreselectMode.None,
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    -- Add tab support
    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
    ["<Tab>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    }),
  },

  -- Installed sources
  sources = {
    { name = "nvim_lsp" },
    { name = "vsnip" },
    { name = "path" },
    { name = "buffer" },
  },
})

EOF
