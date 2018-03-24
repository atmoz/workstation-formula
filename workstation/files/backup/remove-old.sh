#!/bin/bash
set -eu
source /root/backup/conf.sh

echo "--- Remove old backups ---"
duplicity $GPG_ARGS remove-all-inc-of-but-n-full 2 --force $REMOTE_DIR/laptop
duplicity $GPG_ARGS remove-older-than 1Y --force $REMOTE_DIR/laptop
