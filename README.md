# dotfiles
The purpose of this repository is to store all of my dotfiles, and instructions on setting up a new machine.

## Steps for setting up a new machine. 

1. (If using mac) Go to the system preferences -> accessibility and turn on reduce motion.

2. (If using mac) Open a few new desktops and go to system preferences -> keyboard -> keyboard shortcut, and enable mission control desktop switching by number.

3. Pull the dotfiles repository by using the following commands.
```
cd ~
git init
git remote add origin https://github.com/sammyalsadek/dotfiles.git
git fetch
git checkout -f main
```

4. After pulling the repository, run the setup.sh script.
`zsh setup.sh`

5. After the script completes and access is given to yabai run the following command.
`yabai --restart-service`

6. In order to track a new dot file and override the .gitignore configuration, run the following command:
`git add -f <filename>`
