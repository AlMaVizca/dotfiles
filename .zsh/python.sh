alias sshell="manage shell_plus"

workon(){
    source ${VENVS}/$1/bin/activate
}

envs(){
    ls ${VENVS}
}

venv(){
    VPATH=.venv
    VNAME=.env
    [[ -n ${GIT_LOCAL_DIR} ]] && VPROJECT=$(basename ${GIT_LOCAL_DIR})
    # find a parent git directory
    # if that directory contains a virtualenv in a ".venv" directory, activate it



    if [[ (-f "${GIT_LOCAL_DIR}/requirements.txt") ]]; then

        if [[ (-f "${GIT_LOCAL_DIR}/${VNAME}") &&
                  (! -f "${GIT_LOCAL_DIR}/${VPATH}")]]; then
            source ${GIT_LOCAL_DIR}/${VNAME}
            rm -rf ${GIT_LOCAL_DIR}/${VPATH}
            if [[ ! -d ${VENVS}/${VNAME} ]]; then
                echo "Creating venv"
                python3 -m venv ${VENVS}/${VNAME}
            fi
            ln -sf ${VENVS}/${VNAME} ${GIT_LOCAL_DIR}/${VPATH}
    elif [[ ( ! -d "${GIT_LOCAL_DIR}/${VPATH}" ) && ( ! -f "${GIT_LOCAL_DIR}/${VPATH}" )  ]]; then
            python3 -m venv ${VENVS}/${VPROJECT}
            ln -sf ${VENVS}/${VPROJECT} ${GIT_LOCAL_DIR}/.venv
            echo Symlink ${GIT_LOCAL_DIR} ${VENVS}/${VPROJECT} created
            source ${GIT_LOCAL_DIR}/${VPATH}/bin/activate
            pip install -r ~/.pip/requirements.txt >> /dev/null
            pip install -r ${GIT_LOCAL_DIR}/requirements.txt >> /dev/null

            deactivate
        fi
    fi

    if [[ (
            ( -z "$VIRTUAL_ENV" || "$VIRTUAL_ENV" != "${GIT_LOCAL_DIR}/${VPATH}") &&
                -f "${GIT_LOCAL_DIR}/${VPATH}/bin/activate"
        ) ]]; then
        source ${GIT_LOCAL_DIR}/${VPATH}/bin/activate
    fi

    if [[ ($(pwd) = ${GIT_LOCAL_DIR}) && ( -f "requirements.yml" ) ]]; then
        ansible-galaxy install --role-file requirements.yml  --ignore-errors
    fi

    # deactivate an active virtualenv if not ".venv"
    if [[ (-n "$VIRTUAL_ENV" &&
               ("$VIRTUAL_ENV" != "$GIT_LOCAL_DIR}/${VPATH}")) ]]; then
        if [[ ! -f "${GIT_LOCAL_DIR}/${VPATH}/bin/activate" ]] ; then
            echo deactivate
            deactivate
        fi
    fi

}
