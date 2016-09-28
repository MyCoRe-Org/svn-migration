#!/bin/sh
script=$(basename $0);
dir=$(dirname $0);
target="${dir}/git-repos"
mkdir "${target}"
git-svn-migrate/git-svn-migrate.sh --url-file=mycore-svn-list.txt --authors-file=authors.txt "${target}"
