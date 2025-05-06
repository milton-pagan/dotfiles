#!/usr/bin/env bash

set -euo pipefail

DOTFILES_DIR="$HOME/dotfiles"
GIT_NAME="Your Name"
GIT_EMAIL="your@email.com"
SSH_KEY_COMMENT="$GIT_EMAIL"

# Parse flags
AUTO_YES=false
for arg in "$@"; do
  if [[ "$arg" == "--yes" || "$arg" == "-y" ]]; then
    AUTO_YES=true
  fi
done

ask_yes_no() {
  local prompt=$1
  if [[ "$AUTO_YES" == true ]]; then
    echo "$prompt [y/n]: y (auto-confirmed)"
    return 0
  fi
  while true; do
    read -rp "$prompt [y/n]: " yn
    case $yn in
      [Yy]* ) return 0 ;;
      [Nn]* ) return 1 ;;
      * ) echo "Please answer yes or no." ;;
    esac
  done
}

# Function to detect the package manager
detect_pkg_manager() {
  if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "brew"
  elif command -v apt &> /dev/null; then
    echo "apt"
  elif command -v pacman &> /dev/null; then
    echo "pacman"
  else
    echo "Unknown package manager. Please install Homebrew, apt, or pacman."
    exit 1
  fi
}

# Function to install packages
install_packages() {
  local pkg_manager=$1
  if [[ "$pkg_manager" == "brew" ]]; then
    if ! command -v brew &> /dev/null; then
      echo ">> Installing Homebrew..."
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
      mkdir -p "$HOME/.config/fish"
      echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.config/fish/config.fish"
      eval "$(/opt/homebrew/bin/brew shellenv)"
      fish -c 'source ~/.config/fish/config.fish'
    fi
    brew update
    brew install curl git tmux fish ripgrep neovim openssh stow coreutils fzf
  elif [[ "$pkg_manager" == "apt" ]]; then
    sudo apt update
    sudo apt install -y curl git tmux fish ripgrep neovim openssh-client stow build-essential
  elif [[ "$pkg_manager" == "pacman" ]]; then
    sudo pacman -Syu --noconfirm
    sudo pacman -S --noconfirm curl git tmux fish ripgrep neovim openssh stow base-devel
  fi
}

echo ">> Detecting package manager..."
PKG_MANAGER=$(detect_pkg_manager)

if ask_yes_no ">> Do you want to install required packages?"; then
  install_packages "$PKG_MANAGER"
else
  echo ">> Skipping package installation."
fi

if ask_yes_no ">> Do you want to clone and stow dotfiles?"; then
  if [ ! -d "$DOTFILES_DIR" ]; then
    git clone https://github.com/yourusername/dotfiles.git "$DOTFILES_DIR"
  fi
  cd "$DOTFILES_DIR"
  stow --target="$HOME" tmux
  stow --target="$HOME" nvim
  stow --target="$HOME" fish
else
  echo ">> Skipping dotfiles setup."
fi

if ask_yes_no ">> Do you want to set Fish as your default shell?"; then
  FISH_PATH="$(which fish)"
  if ! grep -q "$FISH_PATH" /etc/shells; then
    echo "$FISH_PATH" | sudo tee -a /etc/shells
  fi
  if [ "$SHELL" != "$FISH_PATH" ]; then
    chsh -s "$FISH_PATH"
  fi
else
  echo ">> Skipping default shell change."
fi

if ask_yes_no ">> Do you want to install Fisher and plugins?"; then
  fish -c 'curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher'
  fish -c 'fisher install jorgebucaran/nvm.fish'
else
  echo ">> Skipping Fisher and plugin install."
fi

if ask_yes_no ">> Do you want to configure Git?"; then
  git config --global user.name "$GIT_NAME"
  git config --global user.email "$GIT_EMAIL"
  git config --global init.defaultBranch main
  git config --global pull.rebase false
  git config --global core.editor nvim
else
  echo ">> Skipping Git config."
fi

if ask_yes_no ">> Do you want to generate or use an SSH key?"; then
  SSH_KEY="$HOME/.ssh/id_ed25519"
  if [ ! -f "$SSH_KEY" ]; then
    ssh-keygen -t ed25519 -C "$SSH_KEY_COMMENT" -f "$SSH_KEY" -N ""
    eval "$(ssh-agent -s)"
    ssh-add "$SSH_KEY"
  else
    echo ">> SSH key already exists. Skipping generation."
  fi
  echo ">> Public SSH key (copy this to GitHub/GitLab/etc):"
  cat "$SSH_KEY.pub"
else
  echo ">> Skipping SSH key setup."
fi

if ask_yes_no ">> Do you want to install TPM and Lazy.nvim?"; then
  TPM_DIR="$HOME/.tmux/plugins/tpm"
  if [ ! -d "$TPM_DIR" ]; then
    git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
  else
    echo ">> TPM already installed."
  fi

  LAZY_DIR="$HOME/.local/share/nvim/lazy/lazy.nvim"
  if [ ! -d "$LAZY_DIR" ]; then
    git clone https://github.com/folke/lazy.nvim.git "$LAZY_DIR" --branch=stable
  else
    echo ">> Lazy.nvim already installed."
  fi
else
  echo ">> Skipping TPM and Lazy.nvim install."
fi

echo "\n✅ All done!"
echo "→ Launch tmux and run <prefix> + I to install tmux plugins."
echo "→ Open Neovim to trigger Lazy.nvim plugin installs."
echo "→ Run 'nvm install lts' inside Fish to install Node.js."

