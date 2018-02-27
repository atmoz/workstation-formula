include:
  - .xorg
  - .i3
  - .terminal

gtk+:
  pkg.installed:
    - pkgs:
      - gtk2
      - gtk3

desktop-tools:
  pkg.installed:
    - pkgs:
      - nitrogen # Desktop background manager
      - gcolor2  # Simple color picker
