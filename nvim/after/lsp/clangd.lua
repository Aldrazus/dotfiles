return {
    cmd = {
        'clangd',
        '--background-index',
        '--clang-tidy',
        '--header-insertion=never'
    },
    root_markers = { '.clangd', 'compile_commands.json' },
    workspace_required = false,
    filetypes = { 'c', 'cpp' },
}
