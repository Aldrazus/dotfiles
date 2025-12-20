if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -Ux VULKAN_SDK '~/vulkan/1.4.335.0/x86_64'
set -Ux LD_LIBRARY_PATH $VULKAN_SDK/lib
set -Ux VK_LAYER_PATH $VULKAN_SDK/share/vulkan/explicit_layer.d
set -Ux VK_ADD_LAYER_PATH $VULKAN_SDK/share/vulkan/explicit_layer.d
set -Ux PKG_CONFIG_PATH $VULKAN_SDK/lib/pkgconfig/

set -x EMSDK_QUIET 1
source ~/emsdk/emsdk_env.fish

set -Ux VCPKG_ROOT '~/vcpkg'

set -U fish_user_paths $fish_user_paths $FNM_PATH $VULKAN_SDK/bin $VCPKG_ROOT
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

# pnpm
set -gx PNPM_HOME "/home/aldrazus/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
