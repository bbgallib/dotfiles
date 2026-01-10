# Repository Guidelines

## Project Structure & Module Organization
- `Brewfile`: Homebrew bundle definition for CLI and GUI apps.
- `zsh/`: Shell configuration (`.zshrc`, `.zprofile`, `.zshenv`).
- `git/`: Git config and global ignore (`.gitconfig`, `.gitignore_global`).
- `scripts/`: Setup and macOS defaults scripts (`bootstrap.sh`, `link.sh`, `macos-defaults.sh`).
- `vscode/`: VS Code settings and extension list.
- `intellij/`: IntelliJ plugin list (`installed-plugins.txt`).
- `notes/`: Manual installation notes.

## Build, Test, and Development Commands
- `./scripts/bootstrap.sh`: Installs Homebrew packages via `Brewfile`, links dotfiles, and sets the Git global ignore file.
- `./scripts/macos-defaults.sh`: Applies non-default macOS settings (requires `sudo`).
- `brew bundle --file Brewfile`: Installs or updates Homebrew packages directly.

## Coding Style & Naming Conventions
- Shell scripts use Bash with `set -euo pipefail` and are kept minimal and readable.
- Prefer ASCII text and consistent spacing; avoid long, nested conditionals.
- File naming is lowercase with hyphens when needed (e.g., `macos-defaults.sh`).

## Testing Guidelines
- No automated tests are defined in this repository.
- Validate changes by running `./scripts/bootstrap.sh` and `./scripts/macos-defaults.sh` on a fresh macOS install.

## Commit & Pull Request Guidelines
- No commit message convention is established (no prior history). Use clear, imperative summaries (e.g., "Add macOS defaults script").
- PRs should describe the change, list affected files, and include any required manual steps.

## Security & Configuration Tips
- Do not commit secrets, tokens, or exported IDE settings archives.
- IntelliJ settings should be imported manually from a private backup (see `README.md`).
- If you add new apps or tools, update `Brewfile` and `notes/manual-apps.md` accordingly.
