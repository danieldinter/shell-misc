#!/bin/sh

usage ()
{
        echo "Usage: $(basename "$0") [mode]"
        echo "  Options:"
        echo "          - mode: fetch or pull"
}

function error_exit ()
{
        echo "$1" 1>&2
        usage
        exit 1
}

WORKING_DIRECTORY=`pwd`
echo "Updating all repositories in ${WORKING_DIRECTORY}"

if [ -z "$1" ]
then
        echo "No mode provided. Using default mode."
        MODE="fetch"
elif    [ "$1" = "pull" ]
then
        MODE="pull"
elif [ "$1" = "fetch" ]
then
        MODE="fetch"
else
        error_exit "ERROR: unknown mode $1"
fi

LOGFILE="${WORKING_DIRECTORY}/gitupdateall.log"

echo "Using mode: $MODE"
echo "Using logfile: $LOGFILE"

find . -maxdepth 1 -type d \( ! -name . \) -exec bash -c "cd '{}' && if [ -d '.git' ]; then echo 'Found git repository:'; pwd; echo 'Updating..'; git $MODE -v >> $LOGFILE 2>&1; echo 'Done.'; fi;" \;