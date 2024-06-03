#!/bin/env zsh

# The group and name variables have to be defined inside the group folder
function gitlab-create(){
    gitlab project create --name $argv[1] --namespace ${GITLAB_GROUP}
    echo git@gitlab.com:${GITLAB_NAME}/$argv[1].git
    read -p "Do you want to clone it at ./$argv1?" -n 1 -r
    echo    # (optional) move to a new line
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
       git clone git@gitlab.com:${GITLAB_NAME}/$argv[1].git ./$argv[1]
    fi
}

# Flux autocompletion.
if [[ -x /usr/bin/flux ]]; then
    . <(flux completion zsh)
fi

# Gitlab autocompletion.
if [[ -x /usr/bin/gitlab ]]; then
    autoload -U bashcompinit
    bashcompinit
    eval "$(register-python-argcomplete gitlab)"
fi
