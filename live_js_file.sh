#!/bin/bash

cleanup() {
  echo -e "\n\033[1;31m[!] Script Interrupted. Exiting...\033[0m"
  exit 1
}

trap cleanup SIGINT


if [ -z "$1" ] || [ -z "$2" ];  then
    echo -e "\033[1;31m[-] Error! Usage: $0 https://abcd.example.com 3\033[0m"
    exit 1
fi


katana -u "$1" -jc -em js -fs fqdn -rl "$2" | httpx -mc 200 > JS_files.txt


echo -e "\n\033[38;5;10m[+] Done!\033[0m\n\033[38;5;10m[+] File output saved in\033[0m \033[38;5;28m'JS_files.txt'\033[0m"
