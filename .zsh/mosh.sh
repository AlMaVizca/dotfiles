get_assh_config(){
    assh config json | \
        python -c "
import json,sys
obj = json.load(sys.stdin)
host = obj['hosts']['$1']

command='/usr/bin/mosh --ssh=\'ssh '
if 'Port' in host:
   port = host.get('Port')
   command += '-p ' + port + '\' '
else:
   command += '\' '

command+='$2' + ' -- '

hostname = host.get('HostName')

if 'User' in host:
   user = host.get('User')
   command += user + '@' + hostname
else:
   command += hostname

print(command)
"

}

mosh(){
    command=$(get_assh_config $1 $2)
    zsh -c ${command}
}
