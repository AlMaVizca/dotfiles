alias moodle-cfg-dev="/home/krahser/Repositories/Moodle/moodle-docker/env/dev.ini"
alias moodle="/home/krahser/Repositories/Moodle/moodle-docker/bin/moodle-docker-compose"


moodle-cfg (){
    set -a
    . /home/krahser/Repositories/Moodle/moodle-docker/env/$1.ini
    set +a
}
