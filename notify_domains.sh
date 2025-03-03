#!/bin/bash

DOMAIN="zabka.pl"
PREV_FILE="subs_previous.txt"
CURRENT_FILE="subs_current.txt"
NEW_FILE="subs_new.txt"
HTTPX_FILE="httpx_file.txt"


subfinder -d $DOMAIN -silent > $CURRENT_FILE
assetfinder --subs-only $DOMAIN >> $CURRENT_FILE


sort -u $CURRENT_FILE -o $CURRENT_FILE

if [ ! -f "$PREV_FILE" ]; then
    touch "$PREV_FILE"
fi

if [ -f "$HTTPX_FILE" ]; then
    rm "$HTTPX_FILE"
    echo -e "\033[0;31m[!] Old file $HTTPX_FILE was deleted.\033[0m"
fi


comm -13 <(sort "$PREV_FILE") <(sort "$CURRENT_FILE") > "$NEW_FILE"

if [ -s "$NEW_FILE" ]; then
    cat "$NEW_FILE" | httpx > "$HTTPX_FILE"

    if [ -s "$HTTPX_FILE" ]; then
        notify -data "$HTTPX_FILE" -bulk -provider-config /home/kali/.config/notify/config.yaml
    else
        echo "No new subdomains were found" | notify -provider-config /home/kali/.config/notify/config.yaml
    fi
fi

mv "$CURRENT_FILE" "$PREV_FILE"
