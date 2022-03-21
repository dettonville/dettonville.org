#!/bin/bash

##
## hugo does not cleanup after itself :(
## ref: https://github.com/gohugoio/hugo/issues/379
##


## ref: https://intoli.com/blog/exit-on-errors-in-bash-scripts/
# exit when any command fails
set -e

## https://www.pixelstech.net/article/1577768087-Create-temp-file-in-Bash-using-mktemp-and-trap
TMP_DIR="$(mktemp -d -p ~)"

# keep track of the last executed command
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
# echo an error message before exiting
trap 'echo "\"${last_command}\" command filed with exit code $?."' EXIT
trap 'rm -fr "$TMP_DIR"' EXIT

SCRIPT_NAME=$(basename $0)
SCRIPT_DIR="$( cd "$( dirname "$0" )" && pwd )"
echo "SCRIPT_DIR=[${SCRIPT_DIR}]"

PROJECT_DIR="$( cd "$SCRIPT_DIR/../" && pwd )"

SOURCE=$HOME/foo/hugoroot/
DESTINATION=$PROJECT_DIR/public/
LOG=${SCRIPT_NAME}.log

echo "Building from $SOURCE"
hugo --source="$SOURCE" --destination="$TMP_DIR" --logFile="$LOG"
if [ $? -eq 0 ]; then
    echo "Syncing to $DESTINATION"
    rsync -aq --delete "$TMP_DIR/" "$DESTINATION"
fi
echo "Cleaning up"
rm -r $TMP_DIR
