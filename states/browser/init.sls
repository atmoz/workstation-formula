firejail: pkg.installed

chromium: pkg.installed

/etc/firejail/chromium.profile:
  file.comment:
    - regex: ^private-dev

