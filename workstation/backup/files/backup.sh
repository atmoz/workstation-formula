#!/bin/sh
# https://www.loganmarchione.com/2017/07/backblaze-b2-backup-setup/
set -eu
{% from "workstation/map.jinja" import workstation with context %}
#
# NOTE: This file is managed by salt!
#

USER="{{ workstation.username }}"

export B2_ACCOUNT_ID="{{ workstation.backup.backblaze.account }}"
export B2_ACCOUNT_KEY="{{ workstation.backup.backblaze.key }}"
B2_BUCKET="{{ workstation.backup.backblaze.bucket }}"
B2_PATH="{{ workstation.backup.backblaze.path }}"

RESTIC_REPO_B2="b2:${B2_BUCKET}:${B2_PATH}"
RESTIC_REPO_EXTERNAL="/mnt/restic"
BACKUP_DIRS="{% for include in workstation.backup.include_dirs %}{{ include }} {% endfor %}"
export RESTIC_PASSWORD="{{ workstation.backup.restic_password }}"

function resticCloud() {
    restic -r "$RESTIC_REPO_B2" "$@"
}

function resticExternal() {
    restic -r "$RESTIC_REPO_EXTERNAL" "$@"
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
    sync; sleep 1

    resticExternal backup --exclude-if-present=.no-backup $BACKUP_DIRS
    resticExternal check

    # Some big files that's not updated too often, and don't need encryption
    # TODO make this more general and not too specific for just my use case
    rsync -av "/home/{{ workstation.username }}/0-archive/" "/mnt/archive"
    sync; sleep 1

    # Backup external disk archive to cloud
    resticCloud backup --exclude-if-present=.no-backup /mnt/archive
    resticCloud check

    umount /mnt
}

function cloud() {
    resticCloud backup --exclude-if-present=.no-backup $BACKUP_DIRS
}

${@:-cloud}
