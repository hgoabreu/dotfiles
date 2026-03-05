#!/usr/bin/env bash

if [ ! -d "$HOME/.sdkman" ]; then
  info "Installing SDKMAN..."
  curl -s "https://get.sdkman.io?rcupdate=false" | bash
  ok "SDKMAN installed. Run 'sdk install java' to install a JDK"
else
  ok "SDKMAN already installed"
fi
