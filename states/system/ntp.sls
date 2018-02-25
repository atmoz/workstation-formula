ntp:
  pkg.installed: []
  service.running:
    - name: ntpd
    - enable: True
    - require:
      - pkg: ntp

