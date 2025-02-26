#!/bin/bash

cleanup() {
  echo -e "\n\033[1;31m[!] Script Interrupted. Exiting...\033[0m"
  exit 1
}

trap cleanup SIGINT

output="LinkAndSecret_Finder_JS.txt"


if [ -z "$1" ]; then
  echo -e "\033[1;31mUsage: $0 <input_file>\033[0m"
  exit 1
fi


if [ -f "$output" ]; then
  rm "$output"
  echo -e "\033[0;31m[!] Old file $output was deleted.\033[0m"
fi


while IFS= read -r line
do
  echo -e "\n\n\033[1;32mRunning $line\033[0m"
  echo -e "\033[1;34m[+] Executing LinkFinder\033[0m"
  linkfinder.py -i "$line" -o cli 2>&1

  echo -e "\033[1;34m[+] Executing SecretFinder\033[0m"
  SecretFinder.py -i "$line" -o cli 2>&1
done < "$1" 2>&1 | tee -a "$output"

echo -e "\n\n" | tee -a "$output"
echo -e "\033[1;33m[+] DONE\033[0m\n\0\033[1;33m[+] File output saved in\033[0m \033[38;5;28m'$output'\033[0m"
