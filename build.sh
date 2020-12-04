#!/bin/bash

set -x

export GO_HOME=/usr/local/go
export GOPATH=/go
export PATH=${GOPATH}/bin:${GO_HOME}/bin/:$PATH

PROJECT_ROOT="/go/src/github.com/${GITHUB_REPOSITORY}"
PROJECT_NAME=$(basename $GITHUB_REPOSITORY)

mkdir -p $PROJECT_ROOT
rmdir $PROJECT_ROOT
# without above, following symlink creation fails (?)
ln -s $GITHUB_WORKSPACE $PROJECT_ROOT
cd $PROJECT_ROOT/${SUBDIR}
go get -v ./...

EXT=''

if [ $GOOS == 'windows' ]; then
EXT='.exe'
fi

if [ -z "${EXECUTABLE_NAME}" ]; then
  OUTFILE=${PROJECT_NAME}${EXT}
else 
  OUTFILE=${EXECUTABLE_NAME}${EXT}
fi

if [ -x "./build.sh" ]; then
  COMPILED_FILES=`./build.sh "${OUTFILE}" "${BUILD_OPTS}"`
else
  go build -o ${OUTFILE} "${BUILD_OPTS}"
  COMPILED_FILES="${OUTFILE}"
fi

echo ${COMPILED_FILES}
