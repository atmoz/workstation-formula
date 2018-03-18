### NOTE:
### This is the only state used during bootstrap, when systemd is not
### available. Do not depend on systemd here!

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
    - contents: {{ pillar['hostname'] }}

/etc/hosts:
  host.present:
    - ip: 127.0.0.1
    - names:
      - localhost
      - {{ pillar['hostname'] }}

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
    - contents: {{ pillar['pacman']['mirrorlist'] | yaml_encode }}

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
    - password: {{ pillar['users']['root']['password'] }}

{{ pillar['username'] }}:
  group.present: []
  user.present:
    - password: {{ pillar['users'][pillar['username']]['password'] }}
    - gid: {{ pillar['username'] }}
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
  file.symlink:
    - target: /srv/salt/salt-call
