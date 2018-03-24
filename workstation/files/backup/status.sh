#!/bin/bash
set -eu
source /root/backup/conf.sh

echo "--- Status ---"
# Show collection-status
duplicity $GPG_ARGS collection-status $REMOTE_DIR/laptop
