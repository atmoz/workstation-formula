#!/bin/bash
# Tracking dotfiles using a bare git repo
# https://news.ycombinator.com/item?id=11071754
# https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/
# https://github.com/Siilwyn/my-dotfiles/tree/master/.my-dotfiles
set -eu

# Must clone with https, because salt-call is run with root
# After clone, we set remote to ssh

bin_repo_pub='https://github.com/atmoz/bin.git'
bin_repo='git@github.com:atmoz/bin.git'

dotfiles_repo_pub='https://github.com/atmoz/dotfiles.git'
dotfiles_repo='git@github.com:atmoz/dotfiles.git'

if [ ! -d $HOME/bin ]; then
    git clone $bin_repo_pub $HOME/bin
    git -C $HOME/bin remote set-url origin $bin_repo
fi

git clone --bare $dotfiles_repo_pub $HOME/.dotfiles
dotfiles="git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

if ! $dotfiles checkout -q 2>/dev/null; then
    # Backup any exsisting files
    $dotfiles checkout 2>&1 \
        | egrep "\s+\." | awk {'print $1'} | xargs -I{} sh -c \
        'mkdir -p .dotfiles-backup/$(dirname {}) && mv {} .dotfiles-backup/{}'
fi

$dotfiles checkout
$dotfiles config --local status.showUntrackedFiles no
$dotfiles remote set-url origin $dotfiles_repo
