get_ip(){
 dig $1 | grep -e "^$1" | cut -dA -f2 | grep -oe "[0-9.]*"
}

get_dns() {
    nmcli dev show | grep DNS
}

whatismyip() {
    PUB_IP=$(wget http://checkip.dyndns.org/ -O - -o /dev/null | cut -d: -f 2 | cut -d\< -f 1 | tr -d '[:space:]')
    echo $PUB_IP
    curl https://ipapi.co/$PUB_IP/json/
}


eth_forward(){
    echo 1 > /proc/sys/net/ipv4/ip_forward
    iptables -P FORWARD ACCEPT
    iptables -t nat -A POSTROUTING -s 192.168.27.0/24 -o wlp0s20f0u1u3 -j MASQUERADE
}

network(){
    sudo systemctl $1 NetworkManager
}

dnsmasq-offline(){
    sudo /usr/bin/dnsmasq --no-resolv --keep-in-foreground --no-hosts --bind-interfaces --pid-file=/var/run/NetworkManager/dnsmasq.pid --listen-address=127.0.0.1 --cache-size=400 --clear-on-reload --conf-file=/dev/null --enable-dbus=org.freedesktop.NetworkManager.dnsmasq --conf-dir=/etc/NetworkManager/dnsmasq.d
}
