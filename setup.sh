#!/bin/zsh

# Install homebrew package manager
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> ~/.zshrc
eval "$(/opt/homebrew/bin/brew shellenv)"

# Add alias for neovim
echo 'alias vim=nvim' >> ~/.zshrc

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

brew install screen vim nvim llvm make cmake python java node nvm

sudo ln -sfn /usr/local/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk

mkdir ~/.nvm
export NVM_DIR="$HOME/.nvm"
    [ -s "$(brew --prefix)/opt/nvm/nvm.sh" ] && . "$(brew --prefix)/opt/nvm/nvm.sh" # This loads nvm
    [ -s "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" ] && . "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion

rehash
echo "Setup complete."
