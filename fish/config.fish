if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -U fish_user_paths $fish_user_paths $FNM_PATH
set -Ux EDITOR nvim
set -Ux SUDO_EDITOR nvim
set -Ux VISUAL nvim
set -g fish_prompt_pwd_dir_length 0
