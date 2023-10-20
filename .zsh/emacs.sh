export ESOCKET=/run/user/$(id -u)/emacs/local
hostname=$(hostname)
[[ ${hostname} = 'fenix' ]] && export EDITOR="emacsclient -s ${ESOCKET} -t"

if [[ $EMACS = t ]]; then
 unsetopt zle
 PS1='$ '
fi


[ -n "$EAT_SHELL_INTEGRATION_DIR" ] && \
    source "$EAT_SHELL_INTEGRATION_DIR/zsh"


if [[ -n INSIDE_EMACS ]];
  then
    export TERM=eterm-color
    # if [[ $INSIDE_EMACS == *"term"* ]]
    #   then
    #     add-zsh-hook precmd emacs_ansi_term_support
    # fi
    alias clear='vterm_printf "51;Evterm-clear-scrollback";tput clear'
fi



vterm_printf() {
    if [ -n "$TMUX" ] && ([ "${TERM%%-*}" = "tmux" ] || [ "${TERM%%-*}" = "screen" ]); then
        # Tell tmux to pass the escape sequences through
        printf "\ePtmux;\e\e]%s\007\e\\" "$1"
    elif [ "${TERM%%-*}" = "screen" ]; then
        # GNU screen (screen, screen-256color, screen-256color-bce)
        printf "\eP\e]%s\007\e\\" "$1"
    else
        printf "\e]%s\e\\" "$1"
    fi
}

vterm_prompt_end() {
    vterm_printf "51;A$(whoami)@$(hostname):$(pwd)"
}
setopt PROMPT_SUBST
PROMPT=$PROMPT'%{$(vterm_prompt_end)%}'
