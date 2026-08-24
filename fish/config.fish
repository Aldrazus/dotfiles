if status is-interactive
    fish_config theme choose catppuccin-mocha
end

# Emscripten is optional: configure it only when the SDK is installed locally.
set -l emsdk_env "$HOME/projects/emsdk/emsdk_env.fish"
if test -f $emsdk_env
    set -gx EMSDK_QUIET 1
    source $emsdk_env
end

# pnpm
set -gx PNPM_HOME "$HOME/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH $PNPM_HOME $PATH
end
# pnpm end

# Pi
fish_add_path "/Users/aespinal/.local/share/fnm/node-versions/v26.7.0/installation/bin"
