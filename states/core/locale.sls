en_US.UTF-8 UTF-8:
  locale.present

/etc/locale.conf:
  file.managed:
    - contents: 'LANG=en_US.UTF-8'

/etc/vconsole.conf:
  file.managed:
    - contents: 'KEYMAP=no-latin1'
