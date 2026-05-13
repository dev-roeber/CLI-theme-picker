#!/usr/bin/env bash
# CLI Theme Picker installer
# Copies themes + bin into ~/.config/theme-picker and symlinks scripts into ~/.local/bin.
# Idempotent: re-running is safe.
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TP_HOME="$HOME/.config/theme-picker"

echo "==> Installing CLI Theme Picker into $TP_HOME"
mkdir -p "$TP_HOME/state" "$TP_HOME/backups" "$HOME/.local/bin" \
         "$HOME/.config/bat" "$HOME/.config/fzf" "$HOME/.config/tmux"

# Copy themes + bin (overwrite, but never touch state/backups)
mkdir -p "$TP_HOME/themes" "$TP_HOME/bin"
cp -R "$REPO_DIR/themes/." "$TP_HOME/themes/"
cp -R "$REPO_DIR/bin/."    "$TP_HOME/bin/"
chmod +x "$TP_HOME/bin/"*

# Copy README if present
[ -f "$REPO_DIR/README.md" ] && cp "$REPO_DIR/README.md" "$TP_HOME/README.md"

# Symlink scripts into ~/.local/bin
for s in theme-picker theme-apply theme-sync-server theme-current theme-list theme-rollback theme-generate-all; do
  [ -f "$TP_HOME/bin/$s" ] && ln -sfn "$TP_HOME/bin/$s" "$HOME/.local/bin/$s"
done

echo
echo "==> Required tools (install via your package manager / brew):"
echo "    starship fzf bat tmux git curl jq rsync"
echo
echo "==> Optional: set server host for remote sync"
echo "    export THEME_PICKER_SSH_HOST=user@host"
echo
echo "==> Optional: add ~/.local/bin to PATH if not already"
echo
echo "Done. Try: theme-picker"
