# dotfiles
The purpose of this repository is to store all of my dotfiles, and instructions on setting up a new machine.

## Steps for setting up a new machine.
1. If you are using mac do the following:
- Go to the system preferences -> accessibility and turn on reduce motion.
- Open a few new desktops and go to system preferences -> keyboard -> keyboard shortcut, and enable mission control desktop switching by number.
- Go to system preferences -> keyboard -> keyboard shortcut -> modifier keys, and swap Ctrl and CAPS.
- Assign apps to a desktop through the dock options menu.

2. Pull the dotfiles repository by using the following commands.

```
cd ~
git init
git remote add origin https://github.com/sammyalsadek/dotfiles.git
git fetch
git checkout -f main
```

3. After pulling the repository, run the setup.sh script.

`zsh setup.sh`

4. After the script completes and access is given to yabai run the following command.

`yabai --restart-service`

5. In order to track a new dot file and override the .gitignore configuration, run the following command:

`git add -f <filename>`
