#!/bin/bash

DIR_BIN=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
DIR_DOWNLOAD_ROOT=$(cd "${DIR_BIN}/../www" && pwd)

WGETURL=http://www.mirrorservice.org/sites/ftp.apache.org/maven/maven-3/3.2.3/binaries/apache-maven-3.2.3-bin.tar.gz
echo "downloading apache-maven from ${WGETURL}"
wget  --config "${DIR_BIN}/download.wgetrc"  --no-directories --directory-prefix "${DIR_DOWNLOAD_ROOT}\common" ${WGETURL}
