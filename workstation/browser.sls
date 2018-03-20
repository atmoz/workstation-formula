{% from "workstation/map.jinja" import workstation with context %}

firejail: pkg.installed

chromium: pkg.installed

firefox: pkg.installed

/etc/firejail/chromium.profile:
  file.comment:
    - regex: ^private-dev

