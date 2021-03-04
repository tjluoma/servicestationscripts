#!/usr/bin/env zsh -f
# Purpose: Service Station Script to rename apps in DMGs
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

	# this is just a wrapper around growlnotify
autoload msg

autoload renamedmg

GROWL_APP='iTerm'

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



for i in "${SELECTED_ITEM_URLS[@]}"
do

	msg "Working on '$i:t'... "

	renamedmg "$i"

done

exit 0
#
#EOF
