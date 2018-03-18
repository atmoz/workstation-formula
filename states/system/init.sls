#####################################################################
## Remove message of the day after bootstrap
#####################################################################

/etc/motd:
  file.absent

#####################################################################
## Scripts and dotfiles
#####################################################################

salt://system/binfiles-init.sh:
  cmd.script:
    - cwd: /home/{{ pillar['username'] }}
    - runas: {{ pillar['username'] }}
    - creates: /home/{{ pillar['username'] }}/bin

salt://system/dotfiles-init.sh:
  cmd.script:
    - cwd: /home/{{ pillar['username'] }}
    - runas: {{ pillar['username'] }}
    - creates: /home/{{ pillar['username'] }}/.dotfiles

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
