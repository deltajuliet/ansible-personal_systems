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
    echo "Invalid input received"
    exit 1
else
    echo "Using normal dotfiles"
fi

stow -nvt ~ bash
stow -nvt ~ git
stow -nvt ~ screen
stow -nvt ~ tmux
stow -nvt ~ vim
stow -nvt ~ zsh