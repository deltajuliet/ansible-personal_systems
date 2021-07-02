#!/bin/bash
if [[ $EUID -ne 0 ]]; then
    echo "This script needs to be run as root"
    exit 1
fi

yum -y install perl-Test-Simple perl-Test-Output # Install stow dependencies
mkdir /tmp/stow-latest
cd /tmp/stow-latest
curl -o stow-latest.tar.gz http://ftp.gnu.org/gnu/stow/stow-latest.tar.gz
tar xzf stow-latest.tar.gz --strip-components 1
./configure && make && make install