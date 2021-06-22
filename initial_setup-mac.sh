#!/bin/bash
# initial_setup-mac.sh
#
# installs initial dependancies for using ansible to install/setup Mac systems
#
# Created by Dan Jones

which brew
if [[ $? != 0 ]] ; then
    # Install Homebrew
    echo "[!] Installing Homebrew to install other dependancies"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    echo "[-] Updating Homebrew as it is already installed."
    brew update
fi

