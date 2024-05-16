alias sshell="manage shell_plus"

# pip zsh completion start
function _pip_completion {
  local words cword
  read -Ac words
  read -cn cword
  reply=( $( COMP_WORDS="$words[*]" \
             COMP_CWORD=$(( cword-1 )) \
             PIP_AUTO_COMPLETE=1 $words[1] 2>/dev/null ))
}
compctl -K _pip_completion pip


# pip zsh completion end

create_env(){
    python -v venv ${VENVS}/$1
 }


envs(){
    ls ${VENVS}
}

venv(){
    if [[ ($(pwd) = ${GIT_LOCAL_DIR}) && ( -f "requirements.yml" ) ]]; then
        ansible-galaxy install --role-file requirements.yml  --ignore-errors
    fi
}
