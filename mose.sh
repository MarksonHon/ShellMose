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

nft_enable{
    nft add chian
}