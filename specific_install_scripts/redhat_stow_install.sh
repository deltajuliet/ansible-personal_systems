#!/bin/bash
if [[ $EUID -ne 0 ]]; then
    echo "This script needs to be run as root"
    exit 1
fi

yum -y install perl-Test-Simple perl-Test-Output # Install stow dependencies
curl -o /tmp/stow-latest.tar.gz http://ftp.gnu.org/gnu/stow/stow-latest.tar.gz
tar xzf /tmp/stow-latest.tar.gz
cd /tmp/stow-latest
./configure && make && make install