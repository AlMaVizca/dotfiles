# Alias and functions

# bindkey -r "^[x"
#[[ -d ${MBOOT} ]] && source ${MBOOT}/shell_helpers.sh
#[[ $TERM == "dumb" ]] && unsetopt zle && PS1='$ ' && return

ys(){
    if [[ -n $1 ]]; then
        yat.sh $1
    else
        yat.sh ${EMACS_DAEMON}
    fi
}


emacsdaemon(){
if [ ! -e /tmp/server-${EMACS_DAEMON} ]; then
   touch /tmp/server-${EMACS_DAEMON}
   /usr/bin/emacs --daemon=${EMACS_DAEMON};
fi
}

er() {
    systemctl  --user restart emacs@$1
}

setKeyboardLight () {
    dbus-send --system --type=method_call  --dest="org.freedesktop.UPower" "/org/freedesktop/UPower/KbdBacklight" "org.freedesktop.UPower.KbdBacklight.SetBrightness" int32:$1
}

_git_path(){
    git rev-parse --show-toplevel 2>/dev/null
}

cd(){
    export OLDPWD=$(pwd)
    # first and foremost, change directory
    builtin cd $argv 2> /dev/null

    [[ -n $(_git_path) ]] && export GIT_LOCAL_DIR=$(_git_path) || export GIT_LOCAL_DIR=''

    [[ -f "${GIT_LOCAL_DIR}/shell_helpers.sh" ]] && source ${GIT_LOCAL_DIR}/shell_helpers.sh
    [[ -f "${GIT_LOCAL_DIR}/.bashrc" ]] && source ${GIT_LOCAL_DIR}/.bashrc


    [[ -f $(pwd)/.nvmrc && -r /usr/share/nvm/init-nvm.sh ]] && source /usr/share/nvm/init-nvm.sh
    #venv
    # if [[ -d  "${GIT_LOCAL_DIR}/.githooks" ]]; then
    #     chmod -R +x ${GIT_LOCAL_DIR}/.githooks/
    #     /usr/bin/env cp -a  "${GIT_LOCAL_DIR}/.githooks/." "${GIT_LOCAL_DIR}/.git/hooks/"
    # fi
    #main
}

# upgrade(){
#     cd ~/Repositories/machine_bootstrap/
#     ansible-playbook -l fenix $@ main.yml
#     cd ${OLDPWD}
# }


format_raspberry(){
    cd ~/Work/
    unzip -p 2019-09-26-raspbian-buster-full.zip  |sudo dd bs=4M of=/dev/mmcblk0 conv=fsync
    cd ${OLDPWD}
}
