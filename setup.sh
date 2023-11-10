#!/bin/zsh

# Install homebrew package manager and oh-my-zsh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Set up windows manager on MacOS
if [[ $OSTYPE == 'darwin'* ]]; then
    # Install xcode dev tools.
    xcode-select --install

    # Disable rearranging spaces on most recent use.
    defaults write com.apple.dock mru-spaces -bool false;
    # Disable animations when opening and closing windows.
    defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false
    # Accelerated playback when adjusting the window size.
    defaults write NSGlobalDomain NSWindowResizeTime -float 0.001
    # opening and closing windows and popovers.
    defaults write -g NSAutomaticWindowAnimationsEnabled -bool false
    # smooth scrolling.
    defaults write -g NSScrollAnimationEnabled -bool false
    # showing and hiding sheets, resizing preference windows, zooming windows.
    # float 0 doesn't work.
    defaults write -g NSWindowResizeTime -float 0.001
    # opening and closing Quick Look windows.
    defaults write -g QLPanelAnimationDuration -float 0.001
    # rubberband scrolling (doesn't affect web views).
    defaults write -g NSScrollViewRubberbanding -bool false
    # resizing windows before and after showing the version browser.
    # also disabled by NSWindowResizeTime -float 0.001.
    defaults write -g NSDocumentRevisionsWindowTransformAnimation -bool false
    # showing a toolbar or menu bar in full screen.
    defaults write -g NSToolbarFullScreenAnimationDuration -float 0.001
    # scrolling column views.
    defaults write -g NSBrowserColumnAnimationSpeedMultiplier -float 0.001
    # showing the Dock.
    defaults write com.apple.dock autohide-time-modifier -float 0.001
    defaults write com.apple.dock autohide-delay -float 0.001
    # showing and hiding Mission Control, command+numbers.
    defaults write com.apple.dock expose-animation-duration -float 0.001
    # showing and hiding Launchpad.
    defaults write com.apple.dock springboard-show-duration -float 0.001
    defaults write com.apple.dock springboard-hide-duration -float 0.001
    # changing pages in Launchpad.
    defaults write com.apple.dock springboard-page-duration -float 0.001
    # at least AnimateInfoPanes.
    defaults write com.apple.finder DisableAllAnimations -bool true
    # sending messages and opening windows for replies.
    defaults write com.apple.Mail DisableSendAnimation -bool true
    defaults write com.apple.Mail DisableReplyAnimations -bool true
    killall Dock

    # Install yabai windows manager
    brew install koekeishiya/formulae/yabai
    yabai --start-service
fi

brew install cmake python node nvm java vim
sudo ln -sfn /usr/local/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk
mkdir ~/.nvm
export NVM_DIR="$HOME/.nvm"
    [ -s "$(brew --prefix)/opt/nvm/nvm.sh" ] && . "$(brew --prefix)/opt/nvm/nvm.sh" # This loads nvm
    [ -s "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" ] && . "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion

echo "Rehashing..."
rehash
echo "Rehash complete."
