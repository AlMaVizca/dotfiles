symlinks(){
    ls -l --color=auto `find $1 -maxdepth 1 -type l -print`
}
