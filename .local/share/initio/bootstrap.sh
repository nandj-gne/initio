#!/usr/bin/env bash

#
# Bash shim to boostrap ansible provisioner
# doc: https://docs.ansible.com/ansible/latest/intro_installation.html
#

initio_repo="https://github.com/jnand/initio.git"
branch="${INITIO_BRANCH:-master}"
system_type=$(uname -s)
ansible_dir="$HOME/.config/initio"


#
# Check if already bootstrapped
#
if command yadm list >/dev/null 2>&1; then 
    echo "YADM & initio have boostrapped once before"
    echo "-----"
    echo "run yadm for additional help"
    echo "or excute ansible playbooks individually"
    exit 0
fi

#
# MacOS
#
if [ "$system_type" = "Darwin" ]; then

    # install homebrew if it's missing
    if ! command -v brew >/dev/null 2>&1; then
        echo "Installing homebrew"
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi

    # install ansible
    if ! command -v ansible >/dev/null 2>&1; then
        echo "Installing ansible"
        brew install ansible
    fi

#
# Debian Linux
#
elif [ "$system_type" = "Linux" ] && [ -f "/etc/debian_version" ]; then

    echo "Not Yet Implemented"
    exit 1

else

    echo "Unable to detect supported OS enviroment"
    exit 1

fi


#
# Expecto Initio
#
if ! [ -f "$ansible_dir/runbook.yml" ]; then
    cd $HOME
    git init .
    git remote add origin $initio_repo
    git pull origin $branch
fi


#
# Provision
#
if [ -z "$INITIO_TEST" ]; then
    ansible-galaxy install -r "$ansible_dir/requirements.yml"
    ansible-playbook -vv --ask-become-pass -i "$ansible_dir/hosts" "$ansible_dir/runbook.yml" --connection=local -l localhost "$@"
fi
