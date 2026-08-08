# Repository Guidelines

## Project

This repository contains personal dotfiles and application configuration for shells, editors, terminals, and Pi.

## Structure

- Shell config lives in `.zshrc`, `.bashrc`, and `fish/`.
- Neovim config lives in `nvim/`.
- Terminal/editor config lives in `ghostty/`, `zed/`, and `alacritty.yml`.
- Pi config lives in `pi/agent/` and is symlinked from `~/.pi/agent`.
- Pi LSP configuration lives in `pi/agent/lsp.json`; `pi-lsp` is installed via `settings.json` packages.

## Safety

- Do not commit secrets, tokens, machine-local auth, or session history.
- Keep `pi/agent/auth.json` and `pi/agent/sessions/` ignored.
- Be careful when changing files that are symlink targets from `$HOME`.
- Prefer minimal, targeted edits over broad rewrites.

## Validation

After changing shell config, validate syntax where practical:

```sh
zsh -n .zshrc
bash -n .bashrc
fish -n fish/config.fish
```

After changing Neovim Lua config, use the existing formatter/style conventions and avoid introducing machine-specific paths unless intentionally personal.

## Symlinks

When adding a new managed config, place the canonical file or directory in this repository, then symlink from the expected location in `$HOME` or `~/.config`.
