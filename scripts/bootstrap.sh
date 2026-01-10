#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

run() {
  if [ "${DRY_RUN:-}" = "1" ]; then
    printf '+ %s\n' "$*"
    return 0
  fi
  "$@"
}

run_eval() {
  if [ "${DRY_RUN:-}" = "1" ]; then
    printf '+ eval %s\n' "$*"
    return 0
  fi
  eval "$@"
}

if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew not found. Installing..."
  run /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if [ -x /opt/homebrew/bin/brew ]; then
  run_eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x /usr/local/bin/brew ]; then
  run_eval "$(/usr/local/bin/brew shellenv)"
fi

run brew bundle --file "$ROOT_DIR/Brewfile"
run "$ROOT_DIR/scripts/link.sh"
run git config --global core.excludesfile "$HOME/.gitignore_global"

cat <<'MSG'
Next steps:
- Open a new terminal session to load zsh changes.
- Install any GUI apps that are not managed by Homebrew.
MSG
