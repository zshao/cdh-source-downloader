#!/bin/bash

if [ -z "$2" ]; then
  echo "Usage: $0 [CDHV] [COMP]"
  echo "Example: $0 5.4.1 hadoop"
  echo "Example: $0 5.4.1 hive"
  exit 1
fi

set -eux

CDHV=$1
COMP=$2

CDH_MAJOR_V=${CDHV/.*}
URL_ROOT=http://archive-primary.cloudera.com/cdh${CDH_MAJOR_V}/cdh/${CDH_MAJOR_V}

function auto_guess_comp_version() {
  wget -q -O - $URL_ROOT | grep "${COMP}-[^-]*-cdh${CDHV}-src.tar.gz" | sed "s@.*${COMP}-\\([^-]*\\)-cdh${CDHV}-src.tar.gz.*@\\1@"
}

COMPV=$(auto_guess_comp_version)
echo "Auto guessed version for $COMP = $COMPV"

FILENAME=${COMP}-${COMPV}-cdh${CDHV}-src.tar.gz
URL=$URL_ROOT/$FILENAME

DIR=${COMP}-${COMPV}-cdh${CDHV}


function 1_download() {
echo "== Downloading $URL"
wget -q $URL
}

function 2_extract() {
echo '== Extracting...'
tar zxf $FILENAME
}

function 3_git() {
echo '== git...'
(
cd $DIR
git init
git add -A
git commit -m "Initial commit for $URL"
)
}

function 4_git_ignore {
echo '== git_ignore...'
(
cd $DIR
cat > .gitignore <<EOF
*~
*.jar
*.class
target
EOF
git add .gitignore
git commit -m "Add .gitignore"
)
}


if ! [ -f $FILENAME ]; then
  1_download
fi

if ! [ -d $DIR ]; then
  2_extract
fi

if ! [ -d $DIR/.git ]; then
  3_git
fi

if ! [ -d $DIR/.gitignore ]; then
  4_git_ignore
fi

echo "Success!"
