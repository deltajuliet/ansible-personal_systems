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

if [[ -d ~/.oh-my-zsh ]]; then
  echo "[-] Oh-my-zsh is installed, skipping."
else
  echo "[-] Installing oh-my-zsh"
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  echo "[-] Oh-my-zsh install complete"

if [[ ! -f $ZSH_CUSTOM/themes/spaceship.zsh-theme ]]; then
  echo "[-] Installing oh-my-zsh theme"
  git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
  ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
  echo "[-] Theme install complete"
fi

if [[ ! -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]]; then
  echo "[-] Installs zsh completion"
  git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
  echo "[-] Completed install of zsh completion"
fi

if [[ ! -d ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]]; then
  echo "[-] Installs zsh syntax highlighting"
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
  echo "[-] Completed install of zsh syntax highlighting"
fi

echo "[-] Ensure that permissions are correct for Oh-my-zsh"
chmod -R 755 ~/.oh-my-zsh
echo "Done."

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
