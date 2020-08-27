#!/usr/bin/env zsh -f
# Purpose: Service Station Script to remove quarantine flag from selected file(s)/folder(s)
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

GROWL_APP='Terminal'

for i in "$@"
do

	[[ ! -e "$i" ]] && continue

	# echo "i is >$i<" | tee -a "/tmp/$NAME.log"

	GROWL_ID="$i"

	msg --sticky "Unquarantining
	'$i:t'..."

	xattr -r -d com.apple.quarantine "$i"

	EXIT="$?"

	if [[ "$EXIT" == "0" ]]
	then

		afplay /System/Library/Sounds/Glass.aiff

		msg "Success
		'$i:t'!"

	else

		afplay /System/Library/Sounds/Basso.aiff

		msg --sticky "FAILED to unquarantine: '$i:t'."

	fi

done

exit 0
#
#EOF
