# dotfiles
The purpose of this repository is to store all of my dotfiles.

To setup a new machine to pull these dot files, follow the steps below:
```
cd ~
git init
git remote add origin https://github.com/sammyalsadek/dotfiles.git
git fetch
git checkout -f master
```

In order to track a new dot file and override the .gitignore configuration, run the following command:
```
git add -f <filename>
```
