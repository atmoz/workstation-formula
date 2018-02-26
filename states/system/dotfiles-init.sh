#!/bin/bash
set -eu

# Must clone with https, because salt-call is run with root
# After clone, we set remote to ssh

bin_repo_pub='https://github.com/atmoz/bin.git'
bin_repo='git@github.com:atmoz/bin.git'

dotfiles_repo_pub='https://github.com/atmoz/dotfiles.git'
dotfiles_repo='git@github.com:atmoz/dotfiles.git'

(
    git clone $bin_repo_pub bin
    cd bin
    git remote set-url origin $bin_repo
)

git clone --bare $dotfiles_repo_pub $HOME/.dotfiles
dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

if ! $dotfiles checkout; then
    # Backup any exsisting files
    $dotfiles checkout 2>&1 \
        | egrep "\s+\." | awk {'print $1'} | xargs -I{} sh -c \
        'mkdir -p .dotfiles-backup/$(dirname {}) && mv {} .dotfiles-backup/{}'
fi

$dotfiles checkout
$dotfiles remote set-url origin $dotfiles_repo
