xorg:
  pkg.installed

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
