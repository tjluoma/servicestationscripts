#!/bin/bash

TARGETED_URL=""
MENU_KIND=-1
SELECTED_ITEM_URLS=()

IFS=""
while [[ $# -gt 0 ]]; do
    arg=$1
    case $arg in
        -targetedURL)
            TARGETED_URL=$2 && shift && shift
            ;;
        -menuKind)
            MENU_KIND=$2 && shift && shift
            ;;
        -selectedItemURLs)
            shift
            ;;
        *)
            SELECTED_ITEM_URLS+=($1) && shift
            ;;
    esac
done

syslog -s -l alert "Service Station"
syslog -s -l alert "serviceStationDidSelect"
syslog -s -l alert "TARGETED_URL: ${TARGETED_URL}"
syslog -s -l alert "MENU_KIND: ${MENU_KIND}"
syslog -s -l alert "SELECTED_ITEM_URLS:"
for url in "${SELECTED_ITEM_URLS[@]}"
do
    syslog -s -l alert "${url}"
done

exit 0
