#!/bin/bash

# This script sets up the environment for Hammerspoon-Server-Service-Manager

# Step 1: Install Homebrew (if not already installed)
if ! command -v brew &> /dev/null; then
  echo "Homebrew not found. Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "Homebrew is already installed."
fi

# Step 2: Install necessary services using Homebrew
echo "Installing Apache, Nginx, PHP, and MySQL using Homebrew..."
brew install httpd nginx php mysql

# Step 3: Start the services
echo "Starting Apache, Nginx, PHP, and MySQL services..."
brew services start httpd
brew services start nginx
brew services start php
brew services start mysql

# Step 4: Install Hammerspoon (if not already installed)
if [ ! -d "/Applications/Hammerspoon.app" ]; then
  echo "Hammerspoon not found. Downloading and installing Hammerspoon..."
  curl -L -o Hammerspoon.zip https://github.com/Hammerspoon/hammerspoon/releases/latest/download/Hammerspoon.zip
  unzip Hammerspoon.zip -d /Applications
  rm Hammerspoon.zip
else
  echo "Hammerspoon is already installed."
fi

# Step 5: Copy the init.lua file to Hammerspoon configuration directory
echo "Copying init.lua file to Hammerspoon configuration directory..."
mkdir -p ~/.hammerspoon
cp init.lua ~/.hammerspoon/

# Step 6: Reload Hammerspoon configuration
echo "Reloading Hammerspoon configuration..."
open -a Hammerspoon
osascript -e 'tell application "Hammerspoon" to reload config'

echo "Setup complete! Your Hammerspoon-Server-Service-Manager is now configured."
