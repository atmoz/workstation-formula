#!/bin/bash
set -eu
{%- from "workstation/map.jinja" import workstation with context %}

pid=$$
user="{{ workstation.username }}"
delay="$((60 * 5))"
log="/var/log/last-backup.log"
timeBetweenBackups="$((60 * 60 * 24))"
now="$(date +%s)"
notifyId="$(basename $0)"

function notifyUser() {
    export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$(id -u $user)/bus
    sudo -E -u $user notify-send --replace-file=/tmp/notify-$notifyId "$@"
}

function showTimer() {
    count="$delay"
    unit="sec"
    if [ "$delay" -gt 60 ]; then
        count="$(($delay/60))"
        unit="min"
    fi

    notifyUser -i appointment-new -t $(($delay*1000+1000)) \
        "Backup starting in $count $unit" \
        "$(($timeSinceLastBackup/60/60)) hours since last backup.\nKill $pid to abort."
}

function fail() { notifyUser -u critical "Backup failed!" "See $log"; exit 1; }
function abort() { notifyUser "Backup aborted"; exit 0; }

trap fail ERR
trap abort HUP INT TERM KILL

if [ -f $log ]; then
    lastBackupTime="$(stat -t $log | cut -d' ' -f13)"
    timeSinceLastBackup="$(($now - $lastBackupTime))"
else
    lastBackupTime=0
    timeSinceLastBackup="$timeBetweenBackups"
fi

if [ "$(($lastBackupTime + $timeBetweenBackups))" -lt "$now" ]; then
    showTimer

    # Countdown
    while [ "$delay" -gt 1 ]; do
        [ "$delay" -lt 30 ] && showTimer
        delay="$(($delay-1))"
        sleep 1
    done

    notifyUser -i network-transmit "Starting backup ..."

    /usr/local/sbin/backup.sh 2>&1 > $log

    if [ $? -eq 0 ]; then
        notifyUser -i face-smile "Backup completed" "See $log"
    else
        fail
    fi
fi
