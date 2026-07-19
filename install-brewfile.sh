#!/usr/bin/env sh
set -eu

BREWFILE_DIR="$(cd "$(dirname "$0")" && pwd)"
BREWFILE_PATH="$BREWFILE_DIR/Brewfile"

if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew is not installed. Run install-homebrew.sh first."
  exit 1
fi

if [ ! -f "$BREWFILE_PATH" ]; then
  echo "Brewfile not found at: $BREWFILE_PATH"
  exit 1
fi

echo "The following packages will be installed from $BREWFILE_PATH:"
cat "$BREWFILE_PATH"
echo ""

if [ "${AUTO_APPROVE:-0}" = "1" ]; then
  answer="yes"
elif [ -t 0 ]; then
  printf "Continue with Brewfile install? [y/N]: "
  read -r answer
else
  echo "Non-interactive shell detected. Re-run with AUTO_APPROVE=1 to continue."
  exit 1
fi

case "$answer" in
  y|Y|yes|YES)
    if ! brew bundle --file="$BREWFILE_PATH"; then
      echo "Brewfile installation failed."
      exit 1
    fi
    ;;
  *)
    echo "Cancelled."
    exit 1
    ;;
esac

echo "Brewfile installation finished."
