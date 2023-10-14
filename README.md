# dotfiles
The purpose of this repository is to store all of my dotfiles.

To setup a new machine to pull these fot files, follow the following steps:
```
cd ~
git init
git remote add origin https://github.com/sammyalsadek/dotfiles.git
git fetch
git checkout -f master
```

In order to track a new dot file and override the .gitignore congiguration run the following command
```
git add -f <filename>
```
