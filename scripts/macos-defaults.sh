#!/usr/bin/env bash
set -euo pipefail

run() {
  if [ "${DRY_RUN:-}" = "1" ]; then
    printf '+ %s\n' "$*"
    return 0
  fi
  "$@"
}

# Dock (non-default)
run defaults write com.apple.dock autohide -bool true
run defaults write com.apple.dock magnification -bool true
run defaults write com.apple.dock tilesize -int 28
run defaults write com.apple.dock largesize -int 96
run defaults write com.apple.dock show-recents -bool false
run defaults write com.apple.dock mru-spaces -bool false

# Finder (non-default)
run defaults write com.apple.finder ShowStatusBar -bool true
run defaults write com.apple.finder ShowPathbar -bool true
run defaults write com.apple.finder _FXSortFoldersFirst -bool true
run defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true

# Keyboard / Trackpad (non-default)
run defaults write NSGlobalDomain AppleShowAllExtensions -bool true
run defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
run defaults write NSGlobalDomain "com.apple.keyboard.fnState" -bool true
run defaults write NSGlobalDomain "com.apple.trackpad.scaling" -float 2.5

# Screenshots / Control Center / Power / Updates are omitted because they match macOS defaults.

run killall Dock Finder >/dev/null 2>&1 || true
echo "macOS defaults applied. Some changes may require logout/restart."
