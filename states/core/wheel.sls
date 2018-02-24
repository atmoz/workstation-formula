sudo:
  pkg.installed

/etc/sudoers.d/wheel:
  file.managed:
    - user: root
    - group: root
    - mode: 440
    - contents: |
        %wheel ALL=(ALL) ALL
