{% from "workstation/map.jinja" import workstation with context %}

# Handles screen lock on system events (after suspend, etc.)
xss-lock:
  pkg.installed

#####################################################################
## bootloader
#####################################################################

/boot/loader/loader.conf:
  file.managed:
    - source: salt://workstation/laptop/files/bootloader/loader.conf
    - user: root
    - group: root
    - mode: 755

/boot/loader/entries/arch.conf:
  file.managed:
    - source: salt://workstation/laptop/files/bootloader/arch.conf
    - user: root
    - group: root
    - mode: 755

#####################################################################
## hibernation
#####################################################################

cpupower:
  pkg.installed

blueman:
  pkg.installed

pulseaudio-bluetooth:
  pkg.installed

tlp:
  pkg.installed: []
  service.running:
    - enable: True
    - require:
      - pkg: tlp
    - watch:
      - file: tlp
  file.managed:
    - name: /etc/default/tlp
    - source: salt://workstation/laptop/files/tlp
    - user: root
    - group: root
    - mode: 644

x86_energy_perf_policy:
  pkg.installed

powertop:
  pkg.installed: []
#  file.managed:
#    - name: /etc/systemd/system/powertop.service
#    - source: salt://workstation/laptop/files/powertop.service
#    - user: root
#    - group: root
#    - mode: 644
#  service.running:
#    - enable: True
#    - require:
#      - pkg: powertop
#      - file: powertop

fstrim.timer:
  service.running:
    - enable: True

/etc/systemd/system/getty@tty1.service.d/override.conf:
  file.managed:
    - source: salt://workstation/laptop/files/autologin.conf
    - template: jinja
    - user: root
    - group: root
    - mode: 644

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
    - repl: 'GRUB_CMDLINE_LINUX_DEFAULT="quiet vga=current loglevel=3 rd.systemd.show_status=auto rd.udev.log-priority=3"'
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

