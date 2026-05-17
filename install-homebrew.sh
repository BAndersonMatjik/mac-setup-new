#!/usr/bin/env sh
set -eu

if command -v brew >/dev/null 2>&1; then
  echo "Homebrew is already installed."
  exit 0
fi

echo "Installing Homebrew..."
install_script_url="https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh"
install_script_path="$(mktemp)"
trap 'rm -f "$install_script_path"' EXIT INT TERM

if ! curl -fsSL --connect-timeout 10 --max-time 120 "$install_script_url" -o "$install_script_path"; then
  echo "Failed to download Homebrew installer."
  exit 1
fi
echo "Installer downloaded to: $install_script_path"
echo "Review it before continuing."
echo "Inspect with: less \"$install_script_path\""
if [ "${AUTO_APPROVE:-0}" = "1" ]; then
  answer="yes"
elif [ -t 0 ]; then
  printf "Continue with Homebrew install? [y/N]: "
  read -r answer
else
  echo "Non-interactive shell detected. Re-run with AUTO_APPROVE=1 to continue."
  exit 1
fi

case "$answer" in
  y|Y|yes|YES)
    if ! /bin/bash "$install_script_path"; then
      echo "Homebrew installation failed."
      exit 1
    fi
    ;;
  *)
    echo "Cancelled."
    exit 1
    ;;
esac

echo "Homebrew installation finished."
