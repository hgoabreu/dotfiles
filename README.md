# dotfiles

Personal developer environment setup. One command to go from a fresh Mac to a fully configured terminal.

## What's included

- **Ghostty** -- GPU-accelerated terminal, launches fullscreen, Osaka Jade theme
- **tmux** -- session/window/pane management with Omarchy-style palette-driven theme, auto-save/restore
- **Neovim** -- minimal config with bamboo.nvim colorscheme (Osaka Jade)
- **zsh** -- Oh My Zsh with robbyrussell theme, tmux autostart
- **1Password SSH** -- SSH agent backed by 1Password (keys stored in vault)
- **k9s** -- Kubernetes TUI with Everforest Dark Hard skin and mouse support
- **fzf** -- fuzzy finder for history, files, and directories
- **Dev layouts** -- `tdl`, `tdlm`, `tsl` functions for editor + AI + terminal workflows
- **Brewfile** -- all packages in one place

## Quick start

```bash
git clone https://github.com/hugomiguelabreu/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

Then edit `~/.zshrc.local` for machine-specific config (corporate certs, SDKMAN, NVM, etc.).

## Structure

```
dotfiles/
├── install.sh              # Bootstrap script
├── Brewfile                # Homebrew packages
├── scripts/                # Tool installers (run in sorted order)
│   ├── 01-oh-my-zsh.sh
│   ├── 02-sdkman.sh
│   ├── 03-nvm.sh
│   ├── 04-tmux-plugins.sh
│   └── 05-1password-ssh.sh
├── ghostty/
│   ├── config              # Ghostty terminal config
│   └── themes/
│       └── osaka-jade      # Osaka Jade color palette
├── k9s/
│   ├── config.yaml         # k9s config (mouse, skin)
│   └── skins/
│       └── everforest-dark-hard.yaml
├── nvim/
│   └── init.lua            # Neovim config (lazy.nvim + bamboo.nvim)
├── ssh/
│   ├── config              # SSH config (1Password agent)
│   └── config.local.example # Template for machine-specific SSH hosts
├── tmux/
│   └── tmux.conf           # tmux config
├── zsh/
│   ├── zshrc               # Main shell config
│   └── zshrc.local.example # Template for machine-specific overrides
├── cheatsheet.md           # Keyboard shortcuts reference
└── README.md
```

## How it works

`install.sh` does the following:

1. Installs Homebrew (if missing)
2. Installs packages from `Brewfile`
3. Symlinks config files to their expected locations
4. Backs up any existing configs to `*.bak`
5. Creates `~/.zshrc.local` from the example template
6. Runs every `scripts/*.sh` script in sorted order (Oh My Zsh, SDKMAN, NVM, tmux plugins, etc.)

## Adding new install scripts

To install another tool automatically, add a script under `scripts/`:

1. Create a file like `scripts/05-my-tool.sh` (number prefix sets order).
2. Use the helpers `info`, `ok`, `warn` (they are exported from `install.sh`). Check if the tool is already installed and skip if so.
3. Example:

```bash
#!/usr/bin/env bash

if [ ! -d "$HOME/.my-tool" ]; then
  info "Installing my-tool..."
  # your install commands
  ok "my-tool installed"
else
  ok "my-tool already installed"
fi
```

Scripts run in alphabetical order, so `01-`, `02-`, etc. control the sequence.

## Adding packages

Edit `Brewfile` and run:

```bash
brew bundle --file=~/dotfiles/Brewfile
```

## Adding new tool configs

1. Create a folder: `mkdir ~/dotfiles/newtool`
2. Add config files inside it
3. Add a symlink line in `install.sh`
4. Commit and push

## Machine-specific config

Anything that shouldn't be in the repo goes in `~/.zshrc.local`:

- Corporate SSL certificates
- Work-specific scripts
- SDKMAN, NVM, language version managers
- Private PATH additions

See `zsh/zshrc.local.example` for a full template.

## 1Password SSH

SSH authentication is handled by the 1Password SSH agent. After running `install.sh`:

1. Open **1Password** → **Settings** → **Developer**
2. Enable **Use the SSH Agent**
3. Add your SSH keys to 1Password (or create new ones in the app)

Machine-specific SSH host configs go in `~/.ssh/config.local` (same pattern as `~/.zshrc.local`).

