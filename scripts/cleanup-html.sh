#!/bin/bash

SOURCE=$HOME/foo/hugoroot/
DESTINATION=$HOME/bar/public_html/
LOG=$HOME/baz/hugotest.log

TEMP=`mktemp -d`
echo "Building from $SOURCE"
hugo --source="$SOURCE" --destination="$TEMP" --logFile="$LOG"
if [ $? -eq 0 ]; then
    echo "Syncing to $DESTINATION"
    rsync -aq --delete "$TEMP/" "$DESTINATION"
fi
echo "Cleaning up"
rm -r $TEMP
