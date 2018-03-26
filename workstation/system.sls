{% from "workstation/map.jinja" import workstation with context %}

#####################################################################
## Remove message of the day after bootstrap
#####################################################################

/etc/motd:
  file.absent

#####################################################################
## GPG
#####################################################################

gnupg: pkg.installed

838460D0CBD26750AB26DF8FB9FB68F98F88BA47:
  gpg.present:
    - user: {{ workstation.username }}
    - keyserver: pgp.mit.edu
    - trust: ultimately

#####################################################################
## Scripts and dotfiles
#####################################################################

salt://workstation/files/binfiles-init.sh:
  cmd.script:
    - cwd: /home/{{ workstation.username }}
    - runas: {{ workstation.username }}
    - creates: /home/{{ workstation.username }}/bin

salt://workstation/files/dotfiles-init.sh:
  cmd.script:
    - cwd: /home/{{ workstation.username }}
    - runas: {{ workstation.username }}
    - creates: /home/{{ workstation.username }}/.dotfiles

#####################################################################
## Sync time
#####################################################################

ntp:
  pkg.installed: []
  service.running:
    - name: ntpd
    - enable: True
    - require:
      - pkg: ntp

#####################################################################
## Yubikey
#####################################################################

yubikey-gpg-deps:
  pkg.installed:
    - pkgs:
      - libusb-compat
      - ccid

pcscd:
  service.running:
    - enable: true
    - require:
      - pkg: yubikey-gpg-deps

#####################################################################
## Wireless
#####################################################################

# Run backup script when connected to wifi
/etc/netctl/interfaces/{{ workstation.wireless_interface }}:
  file.managed:
    - user: root
    - group: root
    - mode: 700
    - contents: "ExecUpPost='/usr/local/sbin/backup-notify.sh || true'"
