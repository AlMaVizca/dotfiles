alias dco='docker-compose'
alias dcb='docker-compose build'
alias dce='docker-compose exec'
alias dcps='docker-compose ps'
alias dcrestart='docker-compose restart'
alias dcrm='docker-compose rm'
alias dcr='docker-compose run'
alias dcstop='docker-compose stop'
alias dcup='docker-compose up'
alias dcupd='docker-compose up -d'
alias dcdn='docker-compose down'
alias dcl='docker-compose logs'
alias dclf='docker-compose logs -f'
alias dcpull='docker-compose pull'
alias dcstart='docker-compose start'


dcrb(){
    # if (( docker-compose config --services ))$1 in (); then
    docker-compose build $1
    dcrm -sf $1
    dcupd
    # else
    #     docker-compose config --services
    #     echo "That service is not defined, check previous list."
    # fi

}
