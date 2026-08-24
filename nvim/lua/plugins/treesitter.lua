local languages = {
  "c",
  "cpp",
  "lua",
  "python",
  "javascript",
  "typescript",
  "vimdoc",
  "vim",
  "vue",
  "glsl",
  "scss",
  "java",
  "wgsl",
  "markdown",
  "markdown_inline",
  "yaml",
  "html",
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    dependencies = { "mason-org/mason.nvim" },
    config = function()
      local function install_parsers()
        require("nvim-treesitter").install(languages)
      end

      if vim.fn.executable("tree-sitter") == 1 then
        install_parsers()
      else
        require("mason-registry"):on("package:install:success", function(package)
          if package.name == "tree-sitter-cli" then
            vim.schedule(install_parsers)
          end
        end)
      end

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("treesitter.setup", { clear = true }),
        callback = function(args)
          local buf = args.buf
          local filetype = args.match

          local language = vim.treesitter.language.get_lang(filetype) or filetype
          if not vim.treesitter.language.add(language) then
            return
          end

          vim.wo.foldmethod = "expr"
          vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"

          vim.treesitter.start(buf, language)

          vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },
}
