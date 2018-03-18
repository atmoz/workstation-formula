#!/bin/bash
# Tracking dotfiles using a bare git repo
# https://news.ycombinator.com/item?id=11071754
# https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/
# https://github.com/Siilwyn/my-dotfiles/tree/master/.my-dotfiles
set -eu
fail() { echo >&2 "$@"; exit 1; }

# Must first clone with https, because salt-call is run without yubikey
# After clone, we can set remote to ssh
dotfiles_repo_pub='https://github.com/atmoz/dotfiles.git'
dotfiles_repo='git@github.com:atmoz/dotfiles.git'
gitdir=$HOME/.dotfiles

if [ -d $gitdir ]; then
    fail "$gitdir already exists. Aborting."
fi

git clone --bare $dotfiles_repo_pub $gitdir
dotfiles="git --git-dir=$gitdir --work-tree=$HOME"

if ! $dotfiles verify-commit HEAD; then
    rm -rf $gitdir
    fail "GPG signature check failed for $dotfiles_repo!"
fi

if ! $dotfiles checkout -q 2>/dev/null; then
    # Backup any exsisting files
    $dotfiles checkout 2>&1 \
        | egrep "\s+\." | awk {'print $1'} | xargs -I{} sh -c \
        'mkdir -p .dotfiles-backup/$(dirname {}) && mv {} .dotfiles-backup/{}'
fi

$dotfiles checkout
$dotfiles config --local status.showUntrackedFiles no
$dotfiles remote set-url origin $dotfiles_repo
