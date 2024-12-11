#!/bin/bash

# Portable Nerd Font Installer for Linux and macOS
FONT_NAME="Hack Nerd Font"
FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hack.zip"
FONT_DIR="$HOME/.local/share/fonts"

# macOS font directory
if [[ "$OSTYPE" == "darwin"* ]]; then
  FONT_DIR="$HOME/Library/Fonts"
fi

# Create font directory
mkdir -p "$FONT_DIR"

# If nerd font is not found
if [[ ! -e "$FONT_DIR/HackNerdFont-Regular.ttf" ]]; then
  # Download and install the font
  echo "Downloading $FONT_NAME..."
  curl -fLo "$FONT_NAME.zip" "$FONT_URL"
  echo "Extracting $FONT_NAME..."
  unzip -o "$FONT_NAME.zip" -d "$FONT_DIR"
  rm "$FONT_NAME.zip"

  # Refresh font cache (Linux only)
  if [[ "$OSTYPE" != "darwin"* ]]; then
    echo "Refreshing font cache..."
    fc-cache -fv
  fi

  echo "$FONT_NAME installed successfully!"
fi
