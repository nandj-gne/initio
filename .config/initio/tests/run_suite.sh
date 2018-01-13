#!/usr/bin/env bash

ansible_dir="$HOME/.config/initio"


# Install requirements
ansible-galaxy install -r "$ansible_dir/requirements.yml"

# Syntax check
ansible-playbook -i .config/initio/tests/hosts .config/initio/runbook.yml --syntax-check

# Full test 
time ansible-playbook \
    -vv --ask-become-pass \
    --connection=local \
    --limit localhost \
    --inventory "$ansible_dir/hosts" \
    "$ansible_dir/runbook.yml" "$@"
