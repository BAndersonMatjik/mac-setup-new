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

if ! curl -fsSL "$install_script_url" -o "$install_script_path"; then
  echo "Failed to download Oh My Zsh installer."
  exit 1
fi
echo "Installer downloaded to: $install_script_path"
echo "Review it before continuing."
echo "Inspect with: less \"$install_script_path\""
if [ "${AUTO_APPROVE:-0}" = "1" ]; then
  answer="yes"
elif [ -t 0 ]; then
  printf "Continue with Oh My Zsh install? [y/N]: "
  read -r answer
else
  echo "Non-interactive shell detected. Re-run with AUTO_APPROVE=1 to continue."
  exit 1
fi

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
