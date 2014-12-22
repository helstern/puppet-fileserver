#!/bin/bash -e

#set -x 

DIR_BIN=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
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
    local WGETURL=$1
    local DIRPREFIX="${FILESERVER_ROOT}/${2}"
    local MESSAGE="${3-downloading $WGETURL}"

    echo -en "${MESSAGE}    "

    wget  --progress=dot:mega \
        --config="${DIR_BIN}/download.wgetrc" \
        --no-directories --directory-prefix "${DIRPREFIX}" \
        ${WGETURL} 2>&1 | grep --line-buffered -o "[0-9]*%" | xargs -L1 echo -en "\b\b\b\b"

    echo " DONE"
}

# apache maven binary
WGETURL=http://mirror.gopotato.co.uk/apache/maven/maven-3/3.2.5/binaries/apache-maven-3.2.5-bin.tar.gz
wget_download "${WGETURL}" "modules/apache_maven"

# apache maven source
WGETURL=http://mirror.gopotato.co.uk/apache/maven/maven-3/3.2.5/source/apache-maven-3.2.5-src.tar.gz
wget_download "${WGETURL}" "modules/apache_maven"
