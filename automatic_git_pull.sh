# Assumes that there is already a local copy of the tree existing
# Location of the local copy given as command line parameter
# Does not care about uncommitted changes in our local tree, thus git fetch

#!/bin/bash
DIR=$1

: ${1?"Local working directory needed as an cmd-line argument. Usage: $0 PATH_TO_LOCAL_DIR"}

cd $DIR

if [ "`git log --pretty=%H | head -n 1`" = "`git ls-remote origin -h HEAD|cut -f1`" ] ; then
    statustxt="Repo up to date"
else
    statustxt="Update required. Fecthing the latest"
    # fetch instead of pull to avoid possible merge conflicts
    git fetch && git reset --hard FETCH_HEAD
fi

echo "$statustxt"
