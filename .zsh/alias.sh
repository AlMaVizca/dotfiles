# Emacs
alias emacs='emacsclient -s /tmp/user/$(id -u)/emacs/local -t'
alias es='ps -e | grep emacs'
alias edebug='/usr/bin/emacs --debug-init'
alias emacsclient='emacsclient -s ${ESOCKET}'

# Notifications
alias notify="paplay /usr/share/sounds/freedesktop/stereo/message-new-instant.oga"
alias vagrant-provision="vagrant provision; notify-send 'Vagrant provision' 'Finish'; notify"
alias vagrant-up="vagrant up; notify-send 'Vagrant provision' 'Finish'; notify"
alias semaphore-start="semaphore -config /home/krahser/ansible-playbooks/semaphore_config.json"

## SSH & mosh
alias ssh="assh wrapper ssh"
alias ssh-build="rm -f ~/.ssh/config && assh config build > ~/.ssh/config"
alias ssh-flush="assh sockets flush"
alias newpass="openssl rand -base64"
alias hydrogen="mosh hydrogen.almavizca.xyz"
alias rgrep="grep -ir"
alias passwords_keep="sudo chattr +i ~/.local/share/keyrings/login.keyring"
alias passwords_change="sudo chattr -i ~/.local/share/keyrings/login.keyring"

#tmux
alias ys="yat.sh"

#Makefiles
alias blog="make -C ~/Repositories/AlMaVizca/blog/"
alias bot="make -C ~/Repositories/economics/binance-trading-bot"
alias cache="make -C /home/krahser/Repositories/AlMaVizca/caches/"
alias cihelper="make -C /home/krahser/Repositories/inthependiente/helpers/"
alias databases="make -C /home/krahser/Repositories/inthependiente/databases/"
alias economia="make -C ~/Repositories/economics/econo_mia"
alias finances="make -C ~/Repositories/economics/econo_mia/finances"
alias langtool="make -C ~/Repositories/inthependiente/langtool/"
alias odoo="make -C ~/Repositories/AlMaVizca/odoo/"
