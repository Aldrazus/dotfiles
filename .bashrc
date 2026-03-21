# ~/.bashrc: executed by bash(1) for non-login shells.
# Launches zsh for interactive sessions; zsh config lives in ~/.zshrc.
if test -t 1; then
    exec zsh
fi

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac
