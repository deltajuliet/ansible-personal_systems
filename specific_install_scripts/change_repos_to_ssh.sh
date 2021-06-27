var repo_path=/tmp
var repo_ssh_url=none

function http_to_ssh_git () {
    if [[ -d $repo_path ]]; then
        echo "[!] Switching " + $repo_path + " to ssh"
        cd @repo_path
        git remote set-url origin $repo_ssh_url
    fi
}

var repo_path=~/code/github/dotfiles
var repo_ssh_url="git@github.com:deltajuliet/dotfiles.git"
http_to_ssh_git()

var repo_path=~/code/github/ansible-personal_systems
var repo_ssh_url="git@github.com:deltajuliet/ansible-personal_systems.git"
http_to_ssh_git()