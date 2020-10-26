#!/usr/bin/env zsh -f
# Purpose: Remove Spaces from FIle / Folder names
#
# From:	Timothy J. Luoma
# Mail:	luomat at gmail dot com
# Date:	2020-05-15

NAME="$0:t:r"

if [ -e "$HOME/.path" ]
then
	source "$HOME/.path"
else
	PATH=/usr/local/scripts:/usr/local/bin:/usr/bin:/usr/sbin:/sbin:/bin
fi

autoload msg

GROWL_APP='Service Station'

msg "$@"

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

for PRESTRIP in "${SELECTED_ITEM_URLS[@]}"
do

		# if it doesn't exist then we can't rename it, can we?
	[[ ! -e "$PRESTRIP" ]] && continue

	PRESTRIP=($PRESTRIP(:A))

	PARENT_DIR="$PRESTRIP:h"

	POSTSTRIP=$(echo "$PRESTRIP:t" | tr -s ' ' '-' | tr -s '-' '-')

	if [[ "$PRESTRIP:t" == "$POSTSTRIP" ]]
	then

		msg --sticky "$PRESTRIP has no spaces"

	else

		command mv -vn "${PRESTRIP}" "${PARENT_DIR}/${POSTSTRIP}"

		msg "Renamed '$PRESTRIP'"

	fi

done

exit 0
#
#EOF

