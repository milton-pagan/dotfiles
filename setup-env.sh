#!/usr/bin/env bash

set -euo pipefail

DOTFILES_DIR="$HOME/dotfiles"
GIT_NAME="Your Name"
GIT_EMAIL="your@email.com"
SSH_KEY_COMMENT="$GIT_EMAIL"

# Function to detect the package manager
detect_pkg_manager() {
  if command -v apt &> /dev/null; then
    echo "apt"  # Debian/Ubuntu-based
  elif command -v pacman &> /dev/null; then
    echo "pacman"  # Arch-based
  else
    echo "Unknown package manager. Please install either apt or pacman."
    exit 1
  fi
}

# Function to install packages based on the distro
install_packages() {
  local pkg_manager=$1
  if [[ "$pkg_manager" == "apt" ]]; then
    sudo apt update
    sudo apt install -y \
      curl \
      git \
      tmux \
      fish \
      ripgrep \
      neovim \
      openssh-client \
      stow \
      build-essential
  elif [[ "$pkg_manager" == "pacman" ]]; then
    sudo pacman -Syu --noconfirm
    sudo pacman -S --noconfirm \
      curl \
      git \
      tmux \
      fish \
      ripgrep \
      neovim \
      openssh \
      stow \
      base-devel
  fi
}

echo ">> Detecting package manager..."
PKG_MANAGER=$(detect_pkg_manager)

echo ">> Installing required packages..."
install_packages "$PKG_MANAGER"

echo ">> Installing NVM (Node Version Manager)..."
if [ ! -d "$HOME/.nvm" ]; then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
fi

# Load NVM into this shell session
export NVM_DIR="$HOME/.nvm"
# shellcheck disable=SC1091
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

echo ">> Installing latest LTS version of Node.js..."
nvm install "lts/*"
nvm use "lts/*"
nvm alias default "lts/*"

echo ">> Node version: $(node -v)"
echo ">> npm version: $(npm -v)"

echo ">> Cloning dotfiles (if not already present)..."
if [ ! -d "$DOTFILES_DIR" ]; then
  git clone https://github.com/yourusername/dotfiles.git "$DOTFILES_DIR"
fi

cd "$DOTFILES_DIR"

echo ">> Stowing config files..."
stow nvim
stow tmux
stow fish

echo ">> Setting Fish as default shell..."
if ! grep -q "$(which fish)" /etc/shells; then
  echo "$(which fish)" | sudo tee -a /etc/shells
fi
if [ "$SHELL" != "$(which fish)" ]; then
  chsh -s "$(which fish)"
fi

echo ">> Installing Fisher (Fish plugin manager)..."
fish -c 'curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher'

echo ">> Configuring Git..."
git config --global user.name "$GIT_NAME"
git config --global user.email "$GIT_EMAIL"
git config --global init.defaultBranch main
git config --global pull.rebase false
git config --global core.editor nvim

echo ">> Checking for existing SSH key..."
SSH_KEY="$HOME/.ssh/id_ed25519"
if [ ! -f "$SSH_KEY" ]; then
  echo ">> Generating new SSH key..."
  ssh-keygen -t ed25519 -C "$SSH_KEY_COMMENT" -f "$SSH_KEY" -N ""
  eval "$(ssh-agent -s)"
  ssh-add "$SSH_KEY"
else
  echo ">> SSH key already exists. Skipping generation."
fi

echo ">> Installing TPM (Tmux Plugin Manager)..."
TPM_DIR="$HOME/.tmux/plugins/tpm"
if [ ! -d "$TPM_DIR" ]; then
  git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
else
  echo ">> TPM already installed."
fi

echo ">> Installing Lazy.nvim..."
LAZY_DIR="$HOME/.local/share/nvim/lazy/lazy.nvim"
if [ ! -d "$LAZY_DIR" ]; then
  git clone https://github.com/folke/lazy.nvim.git "$LAZY_DIR" --branch=stable
else
  echo ">> Lazy.nvim already installed."
fi

echo ">> Public SSH key (copy this to GitHub/GitLab/etc):"
cat "$SSH_KEY.pub"

echo "✅ All done!"
echo "→ Launch tmux and run <prefix> + I to install tmux plugins."
echo "→ Open Neovim to trigger Lazy.nvim plugin installs."

