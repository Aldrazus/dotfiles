# Repository Guidelines

## Project

This repository contains personal dotfiles and application configuration for shells, editors, terminals, and Pi. Treat files in this repository as the canonical copies; several are live symlink targets from the home directory.

## Layout

- Shell configuration lives in `fish/` and `Microsoft.PowerShell_profile.ps1`.
- Git configuration lives in `.gitconfig`.
- Tmux configuration lives in `.tmux.conf`.
- Neovim configuration lives in `nvim/`; plugin specifications are split across `nvim/lua/plugins/`, and filetype/LSP overrides live under `nvim/after/`.
- Terminal and editor configuration lives in `ghostty/` and `zed/`.
- Pi configuration lives in `pi/agent/`, which is symlinked from `~/.pi/agent`. `settings.json` installs `pi-lsp`, `lsp.json` configures language servers, and `extensions/` contains source-controlled extensions.
- `pi/agent/npm/`, `pi/agent/bin/`, `pi/agent/sessions/`, and `pi/agent/trust/` are local or generated Pi state and must remain untracked.

## Editing Guidelines

- Prefer minimal, targeted edits and preserve the style of the surrounding file.
- Keep Neovim modules small and follow the existing two-space Lua formatting in `.stylua.toml`.
- Do not introduce machine-specific absolute paths unless the configuration is intentionally personal and the path is required.
- Do not hand-edit generated dependency contents or update `nvim/lazy-lock.json` unless the task changes Neovim plugins.
- Preserve unrelated working-tree changes.

## Safety

- Never commit secrets, tokens, machine-local authentication, session history, or generated runtime data.
- In particular, keep `pi/agent/auth.json` and the ignored Pi runtime directories untracked. Do not read or expose authentication contents unless the task explicitly requires it.
- Check whether a managed file is a live symlink target before making broad or potentially disruptive changes.

## Validation

Run the checks relevant to the files changed, when the required tools are installed:

```sh
fish -n fish/config.fish fish/conf.d/*.fish
git config --file .gitconfig --list
stylua --check nvim
jq empty nvim/lazy-lock.json pi/agent/lsp.json pi/agent/models-store.json \
  pi/agent/settings.json
```

Zed's `.json` files use JSON-with-comments syntax, so validate them through Zed rather than `jq`. For Pi TypeScript extensions, use the existing TypeScript style and verify against the installed Pi package when practical. For other application-specific configuration, prefer that application's built-in validation command if one is available.

## Symlinks

When adding a managed configuration, place the canonical file or directory in this repository, then create the expected symlink under `$HOME` or `$HOME/.config`. Do not replace an existing real file or directory without first preserving it or getting explicit confirmation.
