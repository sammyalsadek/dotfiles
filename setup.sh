#!/bin/zsh

# Install homebrew package manager
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> ~/.zshrc
eval "$(/opt/homebrew/bin/brew shellenv)"

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Set up MacOS
if [[ $OSTYPE == 'darwin'* ]]; then
    # Install xcode dev tools.
    xcode-select --install

    # Disable rearranging spaces on most recent use.
    defaults write com.apple.dock mru-spaces -bool false;
    killall Dock

    # Install yabai windows manager
    brew install koekeishiya/formulae/yabai
    yabai --start-service
fi

rehash
echo "Setup complete."
