wifi-ath(){
    sudo modprobe ath10k_pci
}

wifi-usb(){
    pushd /home/krahser/Repositories/rtl8814/aircrack-ng
    make
    sudo make install
}
