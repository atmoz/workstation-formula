{% from "workstation/map.jinja" import workstation with context %}

#####################################################################
## i3
#####################################################################

i3:
  pkg.installed:
    - pkgs:
      - i3-gaps
      - i3lock
      - i3status
      - dmenu

#####################################################################
## GTK+
#####################################################################

gtk+:
  pkg.installed:
    - pkgs:
      - gtk2
      - gtk3
      - gtk-engines
      - gtk-engine-murrine
      - lxappearance
      - adapta-gtk-theme
      - gnome-themes-extra
      - gnome-icon-theme

#####################################################################
## terminal
#####################################################################

sakura:
  pkg.installed

kitty:
  pkg.installed

#####################################################################
## File manager
#####################################################################

file-manager:
  pkg.installed:
    - pkgs:
      - thunar
      - thunar-archive-plugin
      - gvfs-smb # Virtual filesystem for GIO (SMB/CIFS)

#####################################################################
## xorg
#####################################################################

xorg:
  pkg.installed:
    - pkgs:
      - xorg-server
      - xorg-xinit
      - xorg-xinput
      - xorg-xkill
      - xorg-xsetroot
      - xorg-xbacklight

fonts:
  pkg.installed:
    - pkgs:
      - ttf-fira-mono
      - otf-fira-mono
      - xorg-fonts-100dpi
      - xorg-fonts-75dpi
      - xorg-fonts-misc
      - ttf-croscore
      - ttf-dejavu
      - ttf-droid
      - ttf-roboto
      - noto-fonts
      - ttf-liberation
      - ttf-ubuntu-font-family

#####################################################################
## Drivers
#####################################################################

display-driver:
  pkg.installed:
    - pkgs:
{% for gpu in grains['gpus'] %}
{% if gpu.vendor == 'intel' %}
      - xf86-video-intel
{% elif gpu.vendor == 'nvidia' %}
      - xf86-video-nouveau
      - nvidia
{% else %}
      - xf86-video-vesa
{% endif %}
{% endfor %}

#####################################################################
## Desktop tools
#####################################################################

desktop-tools:
  pkg.installed:
    - pkgs:
      - arandr   # A simple visual front end for XRandR
      - flatpak  # Linux application sandboxing
      - nitrogen # Desktop background manager
      - gcolor2  # Simple color picker
      - feh      # Image viewer
      - pamixer  # Pulseaudio command-line mixer like amixer
      - redshift # Adjusts the color temperature of your screen
      - gnome-disk-utility # Disk Management Utility
      - pavucontrol # PulseAudio Volume Control

#####################################################################
## Notifications
#####################################################################

dunst:
  pkg.installed

/usr/local/bin/notify-send: # without .sh, so we replace the original notify-send
  file.managed:
    - source: salt://workstation/wm/notify-send.sh
    - mode: 755

/usr/local/bin/action-action.sh:
  file.managed:
    - source: salt://workstation/wm/notify-action.sh
    - mode: 755

#####################################################################
## Modified keyboard layout
#####################################################################

/usr/share/X11/xkb/types/iso9995:
  file.managed:
    - source: salt://workstation/wm/xkb/types/iso9995
    - mode: 755

/usr/share/X11/xkb/symbols/capsmod:
  file.managed:
    - source: salt://workstation/wm/xkb/symbols/capsmod
    - mode: 755

