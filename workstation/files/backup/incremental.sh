#!/bin/bash
set -eu
source /root/backup/conf.sh

echo "--- Backup ---"
duplicity $GPG_ARGS \
    --full-if-older-than 30D \
    --exclude-if-present .no-backup \
    --include /home \
    --include /etc \
    --include /srv \
    --exclude / \
    --progress \
    / $REMOTE_DIR/laptop
