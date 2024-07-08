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

if alias cd >/dev/null; then
  unalias cd
fi
cd(){
    # Save previous path and change directory
    export OLDPWD=$(pwd)
    builtin cd $argv 2> /dev/null
    [[ -n $(_git_path) ]] && export GIT_LOCAL_DIR=$(_git_path) || export GIT_LOCAL_DIR=''
 }

findMakefile(){
    MAKEFILE_PATH=$1
    while [[ ! -f ${MAKEFILE_PATH}/Makefile && ${MAKEFILE_PATH} != '/' ]]; do
        MAKEFILE_PATH=$(dirname ${MAKEFILE_PATH})
    done
    echo $MAKEFILE_PATH
}

ci(){
    MAKEFILE_PATH=$(pwd)
    if [ -f Makefile ]; then
        make "$@"
    # Prioritize respository makefile execution
    elif [ -f "${GIT_LOCAL_DIR}/Makefile" ]; then
        make -C ${GIT_LOCAL_DIR} "$@"
    elif [ ! -f ${MAKEFILE_PATH}/Makefile ]; then
        MAKEFILE_PATH=$(findMakefile ${MAKEFILE_PATH})
        make -C ${MAKEFILE_PATH} "$@"
    else
        echo "Makefile not found."
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

[[ -f /opt/asdf-vm/asdf.sh ]] && . /opt/asdf-vm/asdf.sh
[[ -n $(_git_path) ]] && export GIT_LOCAL_DIR=$(_git_path) || export GIT_LOCAL_DIR=''
eval "$(direnv hook zsh)"
