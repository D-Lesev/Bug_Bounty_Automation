#!/bin/bash


if [ -z "$1" ]; then
  echo -e "\033[1;31mUsage: $0 <input_file>\033[0m"
  exit 1
fi


while IFS= read -r line
do
  echo -e "\n\033[1;32mRunning $line\033[0m"
  echo -e "\n"
  echo -e "\033[0;34m[+] Executing LinkFinder\033[0m"
  linkfinder.py -i "$line" -o cli
  echo -e "\n"
  echo -e "\033[0;34m[+] Executing SecretFinder\033[0m"
  SecretFinder.py -i "$line" -o cli
done < "$1"

echo -e "\n\n"
echo -e "\033[1;33m[!!] DONE\033[0m"


