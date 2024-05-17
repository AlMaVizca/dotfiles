# Docker


dkrmnone(){
    dkri "^<none"
}

dkri(){
    for each in $(docker images | grep "${1}" | awk '{print $3}' | uniq); do
        echo ${1}
        echo ${each}
        docker rmi ${each}
    done
}

dkiclean(){
    for each in $(docker volume ls | awk '{print $2}'); do
        [ ${#each} -eq 64 ]?docker volume rm $each
    done
}

dk-get-last(){
    export DOCKER_LAST=$(docker ps | cut -d\  -f1 | awk 'NR==2')
    ## --filter 'status=running'
    }

dk-ip() {
    dk-get-last
    docker inspect --format '{{ .NetworkSettings.IPAddress }}' "$DOCKER_LAST"
}

docker-inspect() {
    dk-get-last
    docker inspect --format '{{ .NetworkSettings }}' "$DOCKER_LAST"
}

docker-run(){
    docker run -t -d $@
    dk-ip
    echo $DOCKER_LAST

}
