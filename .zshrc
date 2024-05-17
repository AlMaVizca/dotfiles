# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#
# if [[ ( $TERM == "dumb" ) && ( -z $INSIDE_EMACS ) ]]; then
#     unsetopt zle
#     PS1='$ '
#     return
# fi


if alias cd >/dev/null; then
  unalias cd
fi

# ZSH_AUTOENV=/home/krahser/Repositories/zsh-autoenv/autoenv.zsh
# [[ -d ${ZSHAUTOENV}  ]] && source ${ZSH_AUTOENV}

source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
# source ~/.xsh
setopt cd_able_vars
[[ -r ~/.zsh.bmk ]] && source ~/.zsh.bmk

for plugin in $(env | awk -F "=" '{print $1}' | grep "ZSH_PLUGIN.*"); do
    if [[ -f ${(P)plugin} ]]; then
        source ${(P)plugin}
    fi
done

if [[ -d ${dotfiles_zsh} ]]; then
    for each in $(ls ${dotfiles_zsh}); do
       source ${dotfiles_zsh}/${each}
   done
fi
