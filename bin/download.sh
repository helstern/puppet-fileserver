#!/bin/bash -e

#set -x 

DIR_BIN=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
DIR_CONF=$( cd "${DIR_BIN}/../conf" && pwd )
FILESERVER_ROOT=$(cd "${DIR_BIN}/../www" && pwd)

#######################################
# use wget to download a file to a dir under fileserver root
# Globals:
#   FILESERVER_ROOT
# Arguments:
#   File Url
#   Directory under fileserver root
#   Message to output
# Returns:
#   None
#######################################
function wget_download()
{
    local DIR="${FILESERVER_ROOT}/${1}"

    if [ ! -f "$DIR/download.txt" ] ; then
        echo "no download.txt list found for ${1}"
    fi

    local MESSAGE="${2-downloading $1}"
    echo -en "${MESSAGE}    "

    wget  --progress=dot:mega \
        --config="${DIR_CONF}/download.wgetrc" \
        --no-directories --directory-prefix "${DIR}" \
        --input-file="${DIR}/download.txt" \
        --no-clobber \
        2>&1 | grep --line-buffered -o "[0-9]*%" | xargs -L1 echo -en "\b\b\b\b"

    echo " DONE"
}

# apache_maven
wget_download "apache_maven"

# ruby-install
wget_download "ruby-install"

# chruby
wget_download "chruby"

