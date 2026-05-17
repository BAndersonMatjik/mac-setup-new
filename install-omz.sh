#!/usr/bin/env sh
set -eu

if [ -d "${HOME}/.oh-my-zsh" ]; then
  echo "Oh My Zsh is already installed."
  exit 0
fi

echo "Installing Oh My Zsh..."
install_script_url="https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh"
install_script_path="$(mktemp)"
trap 'rm -f "$install_script_path"' EXIT INT TERM

curl -fsSL "$install_script_url" -o "$install_script_path"
echo "Installer downloaded to: $install_script_path"
echo "Review it before continuing."
printf "Continue with Oh My Zsh install? [y/N]: "
read -r answer

case "$answer" in
  y|Y|yes|YES)
    RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh "$install_script_path"
    ;;
  *)
    echo "Cancelled."
    exit 1
    ;;
esac

echo "Oh My Zsh installation finished."
