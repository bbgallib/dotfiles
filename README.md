# dotfiles (macOS)

This repo bootstraps a new Mac with Homebrew, zsh settings, and Git config.

## Usage

```sh
./scripts/bootstrap.sh
```

Dry run (print commands only):

```sh
DRY_RUN=1 ./scripts/bootstrap.sh
```

Apply macOS defaults (requires sudo):

```sh
./scripts/macos-defaults.sh
```

Dry run (print commands only):

```sh
DRY_RUN=1 ./scripts/macos-defaults.sh
```

## IntelliJ settings

The IntelliJ settings export is not stored in this repo. Import manually from your
private backup using `File > Manage IDE Settings > Import Settings`.

## Contents

- Brewfile
- zsh/.zshrc, zsh/.zprofile, zsh/.zshenv
- git/.gitconfig, git/.gitignore_global
- vscode/settings.json, vscode/extensions.txt
- intellij/installed-plugins.txt
- scripts/bootstrap.sh, scripts/link.sh, scripts/macos-defaults.sh

## File list

```
Brewfile
README.md
intellij/installed-plugins.txt
notes/manual-apps.md
scripts/bootstrap.sh
scripts/link.sh
scripts/macos-defaults.sh
vscode/extensions.txt
vscode/settings.json
```

## Notes

- The bootstrap script symlinks dotfiles into $HOME and backs up existing files to
  $HOME/.dotfiles-backup-<timestamp>.
- The bootstrap script configures Git to use the global ignore file.
- GUI apps not installed via Homebrew should be installed manually.
