vim.pack.add({"https://github.com/nvim-treesitter/nvim-treesitter"})

require("nvim-treesitter").setup({
    ensure_installed = {
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
        "markdown", -- required by CodeCompanion.nvim
        "markdown_inline", -- required by CodeCompanion.nvim
        "yaml" -- required by CodeCompanion.nvim
    },
    highlight = {enable = true},
    indent = {enable = false},
})
