#!/bin/bash
# initial_setup-mac.sh
#
# installs initial dependancies for using ansible to install/setup Mac systems
#
# Created by Dan Jones

which -s brew
if [[ $? != 0 ]] ; then
    # Install Homebrew
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    brew update
fi

