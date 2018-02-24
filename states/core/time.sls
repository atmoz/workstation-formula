/etc/localtime:
  file.symlink:
    - target: /usr/share/zoneinfo/Europe/Oslo

ntp:
  pkg.installed: []
  service.running:
    - name: ntpd
    - enable: True
    - require:
      - pkg: ntp
