#!/bin/bash
cd ~/code/github/dotfiles

echo "Should I use a custom branch for system specific dotfiles? (y/n)"
read custom

if [[ $custom == "y" ]]; then
    echo "What is the name of the branch to use?"
    read branch_name
    git checkout $branch_name
    if [[ $? != 0 ]]; then
        echo "Something weird happened changing branches, bailing out!"
        exit 1
    fi
elif [[ $custom != "n" ]]; then
    echo "[!] Invalid input received"
    exit 1
else
    echo "[*] Using normal dotfiles"
fi

if [[ -d ~/.oh-my-zsh ]]; then
    if [[ ! -L ~/.zshrc ]]; then
        echo "[!] Moving .zshrc hard file out of the way. Oh-my-zsh just installed?"
        mv ~/.zshrc ~/.zshrc.pre_initial_stow
    fi
fi  

stow -vt ~ bash
stow -vt ~ git
stow -vt ~ htop
stow -vt ~ iterm
stow -vt ~ screen
stow -vt ~ skhd
stow -vt ~ ssh
stow -vt ~ tmux
stow -vt ~ vim
stow -vt ~ yabai
stow -vt ~ zsh
