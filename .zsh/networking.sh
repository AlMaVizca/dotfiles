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

network_status(){
    systemctl status NetworkManager
}
