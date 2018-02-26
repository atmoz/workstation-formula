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
