#!/bin/bash

if command -v tput > /dev/null 2>&1; then
    RED=$(tput setaf 1)
    GREEN=$(tput setaf 2)
    YELLOW=$(tput setaf 3)
    RESET=$(tput sgr0)
fi

show_menu{
    echo "1. Install Xray Service"
    echo "2. Stop Xray Service"
    echo "3. Start/Restart Xray Service"
}

get_prefix_ipv6{
    ip -6 route show | awk -F ' ' '{print $1}' | grep -v ^::1 | grep -v ^fe80 | grep -v ^default
}

nft_enable{
    nft add chain ip nat V2RAY
    nft 'add rule ip nat V2RAY ip daddr 192.168.0.0/16 counter return'
    nft 'add rule ip nat V2RAY ip protocol tcp mark 0xff counter return'
    nft 'add rule ip nat V2RAY ip protocol tcp counter redirect to :12345'
    nft 'add rule ip nat PREROUTING ip protocol tcp counter jump V2RAY'
    nft 'add rule ip nat OUTPUT ip protocol tcp counter jump V2RAY'
}