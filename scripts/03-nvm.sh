#!/usr/bin/env bash

if [ ! -d "$HOME/.nvm" ]; then
  info "Installing NVM..."
  export PROFILE=/dev/null
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
  ok "NVM installed. Run 'nvm install --lts' to install Node.js"
else
  ok "NVM already installed"
fi
