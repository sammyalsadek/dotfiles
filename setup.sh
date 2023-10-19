#!/bin/zsh

xcode-select --install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install cmake python mono nodejs java vim screen
sudo ln -sfn /usr/local/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk

echo "Rehashing..."
rehash
echo "Rehash complete."

cd ~/.vim/bundle/YouCompleteMe
python3 install.py --clangd-completer --ts-completer --java-completer

