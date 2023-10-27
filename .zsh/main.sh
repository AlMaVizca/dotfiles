# Alias and functions

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

unalias cd
cd(){
    export OLDPWD=$(pwd)
    # first and foremost, change directory
    builtin cd $argv 2> /dev/null


    export OLD_GIT_LOCAL_DIR=${GIT_LOCAL_DIR}
    [[ -n $(_git_path) ]] && export GIT_LOCAL_DIR=$(_git_path) || export GIT_LOCAL_DIR=''

    [[ -f ${GIT_LOCAL_DIR}/.nvmrc && -r /usr/share/nvm/init-nvm.sh ]] && source /usr/share/nvm/init-nvm.sh

    if [ -e ${GIT_LOCAL_DIR}/.venv ] && [ ${OLD_GIT_LOCAL_DIR} != ${GIT_LOCAL_DIR} ]; then
        echo 'Changing python venv'
        venv
    fi
}

upgrade(){
    yay -Syu
}


format_raspberry(){
    cd ~/Work/
    unzip -p 2019-09-26-raspbian-buster-full.zip  |sudo dd bs=4M of=/dev/mmcblk0 conv=fsync
    cd ${OLDPWD}
}

# Load variables when the shell starts
cd .
