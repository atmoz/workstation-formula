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
