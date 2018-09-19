{% from "workstation/map.jinja" import workstation with context %}

{% set swap_partition = 'UUID=4b5537c4-855c-48e3-af70-a0a78a3c41e7' %}

# Handles screen lock on system events (after suspend, etc.)
xss-lock:
  pkg.installed

#####################################################################
## hibernation
#####################################################################

/etc/mkinitcpio.conf:
  file.replace:
    - pattern: '^HOOKS=.*$'
    - repl: 'HOOKS=(base udev autodetect modconf block resume filesystems keyboard fsck)'
  cmd.run:
    - name: 'mkinitcpio -p linux'
    - onchanges:
      - file: /etc/mkinitcpio.conf

/etc/default/grub:
  file.replace:
    - pattern: '^GRUB_CMDLINE_LINUX_DEFAULT=.*$'
    - repl: 'GRUB_CMDLINE_LINUX_DEFAULT="quiet vga=current loglevel=3 rd.systemd.show_status=auto rd.udev.log-priority=3 resume={{ swap_partition }}"'
  cmd.run:
    - name: 'grub-mkconfig -o /boot/grub/grub.cfg'
    - onchanges:
      - file: /etc/default/grub

/etc/systemd/logind.conf:
  file.managed:
    - source: salt://workstation/laptop/files/logind.conf
    - user: root
    - group: root
    - mode: 644

