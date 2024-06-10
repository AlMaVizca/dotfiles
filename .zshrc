# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

if alias cd >/dev/null; then
  unalias cd
fi

autoload -Uz compinit && compinit

source /opt/asdf-vm/asdf.sh
source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"


setopt cd_able_vars
[[ -r ~/.zsh.bmk ]] && source ~/.zsh.bmk

for plugin in $(env | awk -F "=" '{print $1}' | grep "ZSH_PLUGIN.*"); do
    if [[ -f ${(P)plugin} ]]; then
        source ${(P)plugin}
    fi
done

load_zsh_dir(){
    for each in $(ls -d $1*); do
        source ${each}
    done
}

if [[ -d ${dotfiles_zsh} ]]; then
    load_zsh_dir ${dotfiles_zsh}
fi

if [[ -d ${dotfiles_secrets_zsh} ]]; then
    load_zsh_dir ${dotfiles_secrets_zsh}
fi

if [[ ( -n $INSIDE_EMACS ) ]]; then
    unsetopt zle
    export PS1=${PROMPT4}
    return
fi
