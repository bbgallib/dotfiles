# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a macOS dotfiles repo that bootstraps a new Mac with Homebrew packages, zsh configuration, Git config, VS Code settings, and macOS system defaults.

## Key Commands

**Full setup (new machine):**
```sh
./scripts/bootstrap.sh
```
Installs Homebrew (if missing), runs `brew bundle`, symlinks dotfiles via `link.sh`, and sets the global gitignore.

**Apply macOS system defaults (requires sudo):**
```sh
./scripts/macos-defaults.sh
```

**Sync only dotfile symlinks:**
```sh
./scripts/link.sh
```

**Register MCP servers (run once after installing Claude Code):**
```sh
./scripts/setup-mcp.sh
```

**Install/update Homebrew packages only:**
```sh
brew bundle --file Brewfile
```

**Dry run (any script):** Prefix with `DRY_RUN=1` to print commands without executing them:
```sh
DRY_RUN=1 ./scripts/bootstrap.sh
```

## Architecture

**Symlink-based:** `link.sh` creates symlinks from `$HOME` into the repo. If a file already exists at the destination and isn't already the correct symlink, it's moved to `$HOME/.dotfiles-backup-<timestamp>/` before the symlink is created. This means re-running `link.sh` is safe and idempotent.

**Files linked by `link.sh`:**
- `zsh/.zshrc`, `zsh/.zprofile`, `zsh/.zshenv` → `$HOME/`
- `zsh/starship.toml` → `$HOME/.config/starship.toml`
- `git/.gitconfig`, `git/.gitignore_global` → `$HOME/`
- `claude/settings.json`, `claude/CLAUDE.md`, `claude/keybindings.json` → `$HOME/.claude/`
- `claude/hooks/statusline.sh` → `$HOME/.claude/hooks/statusline.sh`

**`.mcp.json`** is tracked in git at the repo root. It configures project-scoped MCP servers for this dotfiles project. User-scoped MCP servers (shared across all projects) are registered separately via `scripts/setup-mcp.sh`.

**Brewfile** manages CLI tools, GUI apps (casks), and VS Code extensions in a single file.

## Shell Scripts Convention

All scripts use `#!/usr/bin/env bash` with `set -euo pipefail`. The `run()` helper wraps every side-effecting command so dry-run mode (`DRY_RUN=1`) prints the command instead of executing it.

## No Automated Tests

There is no test suite. Validate changes by running the scripts directly (use `DRY_RUN=1` for a safe preview first).

## Adding New Dotfiles

1. Place the file in the appropriate subdirectory (`zsh/`, `git/`, etc.)
2. Add a `link_file` call in `scripts/link.sh`
3. Run `./scripts/link.sh` to apply
