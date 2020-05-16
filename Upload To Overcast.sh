#!/usr/bin/env zsh -f
# Purpose: Service Station Test Script
#
# From:	Timothy J. Luoma
# Mail:	luomat at gmail dot com
# Date:	2020-05-14

NAME="$0:t:r"

if [ -e "$HOME/.path" ]
then
	source "$HOME/.path"
else
	PATH=/usr/local/scripts:/usr/local/bin:/usr/bin:/usr/sbin:/sbin:/bin
fi

autoload msg

GROWL_IMAGE="$HOME/Pictures/App Icons/Overcast/Overcast-512x512.png"

if ((! $+commands[cloudyuploader] ))
then

	msg --sticky "'cloudyuploader' is required but not found in $PATH" >>/dev/stderr

	exit 1
fi

for i in "$@"
do

	[[ ! -e "$i" ]] && continue

	[[ -d "$i" ]] && continue

	# echo "i is >$i<" | tee -a "/tmp/$NAME.log"

	GROWL_ID="$i"

	msg --sticky "Uploading
	'$i:t'..."

	cloudyuploader --silent "${i}"

	EXIT="$?"

	if [[ "$EXIT" == "0" ]]
	then

		afplay /System/Library/Sounds/Glass.aiff

		msg "Finished
		'$i:t'!"

	else

		msg --sticky "FAILED: '$i:t'."

	fi

done

exit 0
#
#EOF

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



 - `-targetedURL`
 - `-menuKind`
 - `-selectedItemURLs`

