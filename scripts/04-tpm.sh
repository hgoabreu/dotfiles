#!/usr/bin/env bash

if [ -d "$HOME/.tmux/plugins/tpm" ]; then
  ok "TPM already installed"
elif [ -x /opt/homebrew/opt/tpm/share/tpm/tpm ]; then
  ok "TPM installed via Homebrew"
else
  info "Installing TPM..."
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
  ok "TPM installed"
fi
