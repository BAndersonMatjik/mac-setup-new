#!/usr/bin/env sh
set -eu

if [ -d "${HOME}/.oh-my-zsh" ]; then
  echo "Oh My Zsh is already installed."
  exit 0
fi

echo "Installing Oh My Zsh..."
RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo "Oh My Zsh installation finished."
