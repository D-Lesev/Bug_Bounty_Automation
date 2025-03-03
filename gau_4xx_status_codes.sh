#!/bin/bash


cleanup() {
  echo -e "\n\033[1;31m[!] Script Interrupted. Exiting...\033[0m"
  exit 1
}

trap cleanup SIGINT

output_file="gau_URLS_from_4xx_codes.txt"


if [ -z "$1" ]; then
  echo -e "\033[1;31mUsage: $0 <input_file>\033[0m"
  exit 1
fi


if [ -f "$output_file" ]; then
  rm "$output_file"
  echo -e "\033[0;31m[!] Old file $output_file was deleted.\033[0m"
fi

input="$1"
total_urls=$(wc -l < "$input")
counter=0

while IFS= read -r url; do
    ((counter++))
    echo -ne "Running $counter of $total_urls\r"
    
    gau "$url" --mc 200 | grep -E "$url" > "$output_file"
    
done < "$input"

echo -e "\nDone! Results saved in $output_file"
