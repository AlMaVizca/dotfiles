symlinks(){
    ls -l --color=auto `find $1 -maxdepth 1 -type l -print`
}


snapprune(){
    #Removes old revisions of snaps
    #CLOSE ALL SNAPS BEFORE RUNNING THIS
    set -eu
    LANG=en_US.UTF-8 snap list --all | awk '/disabled/{print $1, $3}' |
        while read snapname revision; do
            sudo snap remove "$snapname" --revision="$revision"
        done
}

source <(argocd completion zsh)
