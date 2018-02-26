#!/bin/bash
set -e

alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
git clone --bare {{ pillar['dotfiles-repo'] }} $HOME/.dotfiles

if ! dotfiles checkout; then
    # Backup any exsisting files
    dotfiles checkout 2>&1 | egrep "\s+\." | awk {'print $1'} \
        | xargs -I{} mv {} .dotfiles-backup/{}
fi

dotfiles checkout
