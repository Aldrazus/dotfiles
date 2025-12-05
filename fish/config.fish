if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -U fish_user_paths $fish_user_paths $FNM_PATH
set -Ux EDITOR nvim
set -Ux SUDO_EDITOR nvim
set -Ux VISUAL nvim
set -g fish_prompt_pwd_dir_length 0


# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
test -r '/home/aldrazus/.opam/opam-init/init.fish' && source '/home/aldrazus/.opam/opam-init/init.fish' > /dev/null 2> /dev/null; or true
# END opam configuration
