#!/bin/bash
set -eu
{%- from "workstation/map.jinja" import workstation with context %}

user="{{ workstation.username }}"
notifyId="$(basename $0)"

function notifyUser() {
    export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$(id -u $user)/bus
    sudo -E -u $user notify-send --replace-file=/tmp/notify-$notifyId "$@"
}

type="${1:-wireless}"
status="${2:-none}"
profile="${3:-unknown}"

case "$status" in
    "up")
        notifyUser -i network-$type "Connected" "$profile"

        /usr/local/sbin/backup-notify.sh &
        ;;
    "down")
        notifyUser -i network-$type-offline-symbolic.symbolic "Disconnected" "$profile"
        ;;
    *)
        notifyUser "netctl" "$profile"
        ;;
esac
