### NOTE:
### This is the only state used during bootstrap, when systemd is not
### available. Do not depend on systemd here!

{% from "workstation/map.jinja" import workstation with context %}

#####################################################################
## locale
#####################################################################

en_US.UTF-8 UTF-8:
  locale.present

/etc/locale.conf:
  file.managed:
    - contents: 'LANG=en_US.UTF-8'

/etc/vconsole.conf:
  file.managed:
    - contents: 'KEYMAP=no-latin1'

#####################################################################
## timezone
#####################################################################

/etc/localtime:
  file.symlink:
    - target: /usr/share/zoneinfo/Europe/Oslo

#####################################################################
## network
#####################################################################

/etc/hostname:
  file.managed:
    - contents: {{ workstation.hostname }}

/etc/hosts:
  host.present:
    - ip: 127.0.0.1
    - names:
      - localhost
      - {{ workstation.hostname }}

wireless.packages:
  pkg.installed:
    - pkgs:
      - iw
      - wpa_supplicant
      - dialog

#####################################################################
## pacman
#####################################################################

/etc/pacman.d/mirrorlist:
  file.managed:
    - contents: {{ workstation.pacman.mirrorlist | yaml_encode }}

#####################################################################
## update
#####################################################################

update-system:
  pkg.uptodate:
    - refresh: True

#####################################################################
## users
#####################################################################

root:
  user.present:
    - password: {{ workstation.users.root.password }}

{{ workstation.username }}:
  group.present: []
  user.present:
    - password: {{ workstation.users[workstation.username].password }}
    - gid: {{ workstation.username }}
    - groups:
      - wheel
      - uucp

#####################################################################
## wheel
#####################################################################

sudo:
  pkg.installed

/etc/sudoers.d/wheel:
  file.managed:
    - user: root
    - group: root
    - mode: 440
    - contents: |
        %wheel ALL=(ALL) ALL

#####################################################################
## salt-call
#####################################################################

/usr/local/bin/salt-call:
  file.managed:
    - source: salt://workstation/core/salt-call
    - template: jinja
    - user: root
    - group: root
    - mode: 700
