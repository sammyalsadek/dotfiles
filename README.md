# dotfiles
The purpose of this repository is to store all of my dotfiles, and instructions on setting up a new machine.

## Steps for setting up a new machine.
1. Pull the dotfiles repository by using the following commands.

```
cd ~
git init
git remote add origin https://github.com/sammyalsadek/dotfiles.git
git fetch
git checkout -f main
```

2. Install Oh-My-Zsh
- https://ohmyz.sh/
- Update the theme in the .zshrc file to `ZSH_THEME="af-magic"`

3. Install Homebrew (Package manager)
- https://brew.sh/

4. Install Yabai (Tiling windows manager)
- https://github.com/koekeishiya/yabai
- Go to system preferences -> accessibility -> display -> turn on reduce motion.
- Open new desktops -> go to system preferences -> keyboard -> keyboard shortcuts -> mission control -> enable mission control -> add shortcuts for desktop switching by cmd + number.
- Assign apps to a desktop through the application right click options in the dock.

5. Install FlyCut (Clipboard manager)
- https://formulae.brew.sh/cask/flycut#default

6. Swap the Caps key with Ctrl
- Go to system preferences -> keyboard -> keyboard shortcut -> modifier keys -> swap Ctrl and Caps.
