if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -Ux JAVA_HOME /opt/jdk1.8.0_202
set -U fish_user_paths $fish_user_paths /opt/nvim-linux-x86_64/bin $JAVA_HOME/bin
set -Ux EDITOR nvim
set -Ux SUDO_EDITOR nvim
set -Ux VISUAL nvim
set -g fish_prompt_pwd_dir_length 0
