/etc/localtime:
  file.symlink:
    - target: /usr/share/zoneinfo/Europe/Oslo

ntp:
  pkg.installed: []
{% if not pillar['bootstrap'] %}
  service.running:
    - name: ntpd
    - enable: True
    - require:
      - pkg: ntp
{% endif %}
