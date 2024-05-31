#!/bin/env zsh

export GITLAB_Nomanod=$(pass show Work/gitlab.com/group_nomanod)
export GITLAB_Awrora=$(pass show Work/gitlab.com/group_awrora)
export GITLAB_Grallamadrid=$(pass show Work/gitlab.com/group_grallamadrid)
export GITLAB_ingeniero=$(pass show Work/gitlab.com/group_ingeniero)
export GITLAB_inthependiente=$(pass show Work/gitlab.com/group_inthependiente)
# The generic group definition is to avoid memorization.
# On the group folder, using direnv (.envrc) there will be a definition for
# GITLAB_GROUP.
# For example:
# export GITLAB_GROUP=${GITLAB_ingeniero}

function gitlab-create(){
    gitlab project create --name $argv[1] --namespace ${GITLAB_GROUP}
    echo git@gitlab.com:${GITLAB_NAME}/$argv[1].git
    read -p "Do you want to clone it at ${GITLAB_PATH}/$argv1?" -n 1 -r
    echo    # (optional) move to a new line
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
       git clone git@gitlab.com:${GITLAB_NAME}/$argv[1].git ${GITLAB_PATH}/$argv[1]
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
