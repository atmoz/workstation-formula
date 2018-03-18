#!/bin/bash
set -eu
fail() { echo >&2 "$@"; exit 1; }

# Must first clone with https, because salt-call is run without yubikey
# After clone, we can set remote to ssh
bin_repo_pub='https://github.com/atmoz/bin.git'
bin_repo='git@github.com:atmoz/bin.git'
gitdir=$HOME/bin

if [ -d $gitdir ]; then
    fail "$gitdir already exists. Aborting."
fi

git clone $bin_repo_pub $gitdir
git -C $gitdir remote set-url origin $bin_repo

if ! git -C $gitdir verify-commit HEAD; then
    rm -rf $gitdir
    fail "GPG signature check failed for $bin_repo! Files are deleted."
fi
