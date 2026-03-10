#!/usr/bin/env bash

# Skip on Linux
if [[ "$(uname)" != "Darwin" ]]; then
  info "Skipping yabai + skhd (not macOS)"
  return 0 2>/dev/null || exit 0
fi

if ! command -v yabai &>/dev/null || ! command -v skhd &>/dev/null; then
  warn "yabai or skhd not found — install via brew bundle first"
  return 0 2>/dev/null || exit 0
fi

info "Starting yabai and skhd services..."

yabai --start-service 2>/dev/null || true
skhd --start-service 2>/dev/null || true

ok "yabai + skhd services started"
