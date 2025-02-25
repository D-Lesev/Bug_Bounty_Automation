#!/bin/bash

if [ -z "$1" ] || [ -z "$2" ];  then
    echo -e "\033[1;31m[-] Error! Usage: $0 <main domain> <domain we want>\033[0m"
    exit 1
fi


gau "$1" | grep -E "^https://$2/.*\.js(\?.*)?$" | httpx -mc 200 > "live_js_$2"
