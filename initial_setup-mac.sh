#!/bin/bash
# initial_setup-mac.sh
#
# installs initial dependancies for using ansible to install/setup Mac systems
#
# Created by Dan Jones

ZSH_CUSTOM=~/.oh-my-zsh/custom

unamestr=`uname`
if [[ "$unamestr" == 'Darwin' ]]; then
  echo "[-] Mac detected, proceeding with install"
else
  echo "[!] This doesn't appear to a Mac! Aborting!"
  exit 1
fi

which brew
if [[ $? != 0 ]]; then
    # Install Homebrew
    echo "[!] Installing Homebrew to install other dependancies"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "[-] Updating Homebrew as it is already installed."
    brew update
fi

#Install ansible
which ansible
if [[ $? != 0 ]] ; then
  echo "[-] Installing Ansible"
  brew install ansible git
  echo "[-] Ansible install complete!"

  echo "[-] Installing Ansible mods needed for playbooks"
  ansible-galaxy collection install community.general
  echo "[-] Mod install complete"
fi

echo "[-] Running Mac Ansible playbook"
ansible-playbook laptop-initial_mac.yml
echo "[-] Playbook run complete"

cd ~/code/github/dotfiles
#stow -vt ~ iterm

echo "If a Yubikey is needed for cloning dotfile repos, run the following:/n"
echo "
yubikey_ssh_enable () {
    ssh-add -l 1> /dev/null 2>/dev/null
#    if [[ $? -eq 0 ]] {
        echo \"Enabling Yubikey for use with SSH. Sudo password needed to restart gpg-agent with ssh support...\"
        sudo killall gpg-agent
        sudo killall ssh-agent  
        eval \$( gpg-agent --daemon --enable-ssh-support )
        ssh-add -l
#    }
}
"
