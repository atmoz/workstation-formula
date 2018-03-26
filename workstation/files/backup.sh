#!/bin/sh
# https://www.loganmarchione.com/2017/07/backblaze-b2-backup-setup/
set -eu
{% from "workstation/map.jinja" import workstation with context %}
#
# NOTE: This file is managed by salt!
#

# Backblaze B2 configuration variables
export B2_ACCOUNT="{{ workstation.backup.backblaze.account }}"
export B2_KEY="{{ workstation.backup.backblaze.key }}"
export B2_BUCKET="{{ workstation.backup.backblaze.bucket }}"
export B2_PATH="{{ workstation.backup.backblaze.path }}"

export REMOTE_DIR="b2://${B2_ACCOUNT}:${B2_KEY}@${B2_BUCKET}/${B2_PATH}"

# GPG keys
export ENC_KEY_YUBIKEY="838460D0CBD26750AB26DF8FB9FB68F98F88BA47"
export ENC_KEY_LOCAL="{{ workstation.backup.local_key }}"
export SIG_KEY_LOCAL="{{ workstation.backup.local_key }}"
export GPG_ARGS="--use-agent \
--encrypt-key $ENC_KEY_YUBIKEY \
--encrypt-key $ENC_KEY_LOCAL \
--sign-key $SIG_KEY_LOCAL"

# local key can be generated with:
# gpg --expert --full-generate-key (select (8) RSA with C, S and E)

# Dirs to ignore
#echo "### Directories that will be ignored:"
#find / -name .no-backup -type f

function cleanup() {
    echo "--- Cleanup ---"
    # Cleanup failures
    duplicity $GPG_ARGS cleanup --force $REMOTE_DIR/laptop
    echo "--- Remove old backups ---"
    duplicity $GPG_ARGS remove-all-inc-of-but-n-full 2 --force $REMOTE_DIR/laptop
    duplicity $GPG_ARGS remove-older-than 1Y --force $REMOTE_DIR/laptop
}

function incremental() {
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
}

function collection_status() {
    echo "--- Status ---"
    # Show collection-status
    duplicity $GPG_ARGS collection-status $REMOTE_DIR/laptop
}

function run() {
    incremental
    cleanup
    collection_status
}

${1:-run}
