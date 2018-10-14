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
export REMOTE_DIR_SIMPLE="b2://${B2_BUCKET}/${B2_PATH}"

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
{%- for include in workstation.backup.include_dirs %}
{%- if salt['file.directory_exists'](include) %}
        --include {{ include }} \
{%- endif %}
{%- endfor %}
        --exclude / \
        --progress \
        / $1
}

# This is supposed to be run manually whenever you connect your external backup disk
function external() {
    externalUuid="{{ workstation.backup.external_uuid }}"

    if ! blkid --uuid "$externalUuid" > /dev/null; then
        echo "External disk not present. Skipping external backup."
        return
    fi

    if mountpoint -q /mnt; then
        echo "/mnt already mounted. Skipping external backup."
        return
    fi

    mount "/dev/disk/by-uuid/$externalUuid" /mnt
    sync
    sleep 1

    # Local copy of backup
    incremental file:///mnt/laptop

    # Some big files that's not updated too often, and don't need encryption
    # TODO make this more general and not too specific for just my use case
    rsync -av "/home/{{ workstation.username }}/archive/" "/mnt/archive"

    b2 authorize-account $B2_ACCOUNT $B2_KEY
    b2 sync --keepDays 30 --threads 1 /mnt/archive $REMOTE_DIR_SIMPLE/archive

    sync
    umount /mnt
}

function collection_status() {
    echo "--- Status ---"
    # Show collection-status
    duplicity $GPG_ARGS collection-status $REMOTE_DIR/laptop
}

function run() {
    incremental $REMOTE_DIR/laptop
    cleanup
    collection_status
}

${1:-run}