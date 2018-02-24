/etc/pacman.d/mirrorlist:
  file.managed:
    - contents: {{ pillar['pacman']['mirrorlist'] | yaml_encode }}
