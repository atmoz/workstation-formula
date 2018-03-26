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

#####################################################################
## terminal
#####################################################################

sakura:
  pkg.installed

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
      - nitrogen # Desktop background manager
      - gcolor2  # Simple color picker
      - feh      # Image viewer

#####################################################################
## Notifications
#####################################################################

dunst:
  pkg.installed

/usr/local/bin/notify-send: # without .sh, so we replace the original notify-send
  file.managed:
    - source: salt://workstation/files/notify-send.sh
    - mode: 755

/usr/local/bin/action-action.sh:
  file.managed:
    - source: salt://workstation/files/notify-action.sh
    - mode: 755

