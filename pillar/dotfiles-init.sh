#!/bin/bash
set -e

# Must clone with https, because salt-call is run with root
# After clone, we set remote to ssh

bin_repo_pub='https://github.com/atmoz/bin.git'
bin_repo='git@github.com:atmoz/bin.git'

(
    git clone $bin_repo_pub bin
    cd bin
    git remote set-url origin $dotfiles_repo
)

dotfiles_repo_pub= 'https://github.com/atmoz/dotfiles.git'
dotfiles_repo='git@github.com:atmoz/dotfiles.git'

alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
git clone --bare $dotfiles_repo_pub $HOME/.dotfiles

if ! dotfiles checkout; then
    # Backup any exsisting files
    dotfiles checkout 2>&1 | egrep "\s+\." | awk {'print $1'} \
        | xargs -I{} mv {} .dotfiles-backup/{}
fi

dotfiles checkout
dotfiles remote set-url origin $dotfiles_repo
