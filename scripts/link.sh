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

  run ln -s "$src" "$dest"
}

link_file "$ROOT_DIR/zsh/.zshrc" "$HOME/.zshrc"
link_file "$ROOT_DIR/zsh/.zprofile" "$HOME/.zprofile"
link_file "$ROOT_DIR/zsh/.zshenv" "$HOME/.zshenv"
link_file "$ROOT_DIR/git/.gitconfig" "$HOME/.gitconfig"
link_file "$ROOT_DIR/git/.gitignore_global" "$HOME/.gitignore_global"

printf 'Linked dotfiles. Backup directory: %s\n' "$BACKUP_DIR"
