#!/bin/bash
set -eu
source /root/backup/conf.sh

echo "--- Cleanup ---"
# Cleanup failures
duplicity $GPG_ARGS cleanup --force $REMOTE_DIR/laptop

