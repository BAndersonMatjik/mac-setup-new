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

curl -fsSL "$install_script_url" -o "$install_script_path"
echo "Installer downloaded to: $install_script_path"
echo "Review it before continuing."
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
    /bin/bash "$install_script_path"
    ;;
  *)
    echo "Cancelled."
    exit 1
    ;;
esac

echo "Homebrew installation finished."
