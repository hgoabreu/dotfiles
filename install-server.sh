#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")" && pwd)"
export DOTFILES

info()  { printf "\033[1;34m[dotfiles]\033[0m %s\n" "$1"; }
ok()    { printf "\033[1;32m[dotfiles]\033[0m %s\n" "$1"; }
warn()  { printf "\033[1;33m[dotfiles]\033[0m %s\n" "$1"; }
export -f info ok warn

# ─── System packages ────────────────────────────────────────
PACKAGES="zsh tmux fzf neovim git jq ripgrep tree curl unzip fd-find"

if command -v apt-get &>/dev/null; then
  info "Installing packages via apt..."
  sudo apt-get update -qq
  sudo apt-get install -y $PACKAGES
  # Debian/Ubuntu installs fd as fdfind — symlink to fd
  if command -v fdfind &>/dev/null && ! command -v fd &>/dev/null; then
    sudo ln -sf "$(command -v fdfind)" /usr/local/bin/fd
    ok "Symlinked fdfind -> fd"
  fi
elif command -v dnf &>/dev/null; then
  info "Installing packages via dnf..."
  sudo dnf install -y $PACKAGES
else
  warn "No supported package manager found (need apt-get or dnf)"
  exit 1
fi
ok "System packages installed"

# ─── Set zsh as default shell ────────────────────────────────
if [ "$(basename "$SHELL")" != "zsh" ]; then
  ZSH_PATH="$(command -v zsh)"
  if ! grep -qx "$ZSH_PATH" /etc/shells; then
    info "Adding $ZSH_PATH to /etc/shells..."
    echo "$ZSH_PATH" | sudo tee -a /etc/shells >/dev/null
  fi
  info "Changing default shell to zsh..."
  sudo chsh -s "$ZSH_PATH" "$(whoami)"
  ok "Default shell set to zsh"
else
  ok "zsh is already the default shell"
fi

source "$DOTFILES/install-common.sh"
