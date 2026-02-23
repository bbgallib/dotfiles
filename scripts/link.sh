#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%Y%m%d%H%M%S)"

run() {
  if [ "${DRY_RUN:-}" = "1" ]; then
    printf '+ %s\n' "$*"
    return 0
  fi
  "$@"
}

link_file() {
  local src="$1"
  local dest="$2"

  if [ -L "$dest" ] || [ -e "$dest" ]; then
    if [ "$(readlink "$dest" 2>/dev/null)" = "$src" ]; then
      return
    fi
    run mkdir -p "$BACKUP_DIR"
    run mv "$dest" "$BACKUP_DIR/"
  fi

  run mkdir -p "$(dirname "$dest")"
  run ln -s "$src" "$dest"
}

link_file "$ROOT_DIR/zsh/.zshrc" "$HOME/.zshrc"
link_file "$ROOT_DIR/zsh/.zprofile" "$HOME/.zprofile"
link_file "$ROOT_DIR/zsh/.zshenv" "$HOME/.zshenv"
link_file "$ROOT_DIR/zsh/starship.toml" "$HOME/.config/starship.toml"
link_file "$ROOT_DIR/git/.gitconfig" "$HOME/.gitconfig"
link_file "$ROOT_DIR/git/.gitignore_global" "$HOME/.gitignore_global"
link_file "$ROOT_DIR/claude/settings.json"    "$HOME/.claude/settings.json"
link_file "$ROOT_DIR/claude/CLAUDE.md"        "$HOME/.claude/CLAUDE.md"
link_file "$ROOT_DIR/claude/keybindings.json" "$HOME/.claude/keybindings.json"

printf 'Linked dotfiles. Backup directory: %s\n' "$BACKUP_DIR"
