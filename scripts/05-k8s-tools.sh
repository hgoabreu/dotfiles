#!/usr/bin/env bash

ARCH="$(uname -m)"
case "$ARCH" in
  x86_64)  ARCH="amd64" ;;
  aarch64|arm64) ARCH="arm64" ;;
esac
OS="$(uname -s | tr '[:upper:]' '[:lower:]')"

install_binary() {
  local name="$1" url="$2"
  if command -v "$name" &>/dev/null; then
    ok "$name already installed"
    return
  fi
  info "Installing $name..."
  local tmp
  tmp="$(mktemp)"
  curl -fSL --connect-timeout 10 --max-time 120 "$url" -o "$tmp"
  chmod +x "$tmp"
  sudo mv "$tmp" "/usr/local/bin/$name"
  ok "$name installed"
}

# kubectl
if ! command -v kubectl &>/dev/null; then
  KUBECTL_VER="$(curl -fsSL --connect-timeout 10 --max-time 30 https://dl.k8s.io/release/stable.txt)"
  install_binary kubectl "https://dl.k8s.io/release/${KUBECTL_VER}/bin/${OS}/${ARCH}/kubectl"
else
  ok "kubectl already installed"
fi

# helm
if ! command -v helm &>/dev/null; then
  info "Installing helm..."
  curl -fsSL --connect-timeout 10 --max-time 30 https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
  ok "helm installed"
else
  ok "helm already installed"
fi

# kind
if ! command -v kind &>/dev/null; then
  KIND_VER="$(curl -fsSL --connect-timeout 10 --max-time 30 https://api.github.com/repos/kubernetes-sigs/kind/releases/latest | grep '"tag_name"' | sed -E 's/.*"([^"]+)".*/\1/')"
  install_binary kind "https://kind.sigs.k8s.io/dl/${KIND_VER}/kind-${OS}-${ARCH}"
else
  ok "kind already installed"
fi

# k9s
if ! command -v k9s &>/dev/null; then
  info "Installing k9s..."
  K9S_VER="$(curl -fsSL --connect-timeout 10 --max-time 30 https://api.github.com/repos/derailed/k9s/releases/latest | grep '"tag_name"' | sed -E 's/.*"([^"]+)".*/\1/')"
  K9S_ARCH="$ARCH"
  [ "$K9S_ARCH" = "amd64" ] && K9S_ARCH="amd64"
  [ "$K9S_ARCH" = "arm64" ] && K9S_ARCH="arm64"
  tmp="$(mktemp -d)"
  curl -fSL --connect-timeout 10 --max-time 120 "https://github.com/derailed/k9s/releases/download/${K9S_VER}/k9s_${OS}_${K9S_ARCH}.tar.gz" -o "$tmp/k9s.tar.gz"
  tar -xzf "$tmp/k9s.tar.gz" -C "$tmp"
  sudo mv "$tmp/k9s" /usr/local/bin/k9s
  rm -rf "$tmp"
  ok "k9s installed"
else
  ok "k9s already installed"
fi
