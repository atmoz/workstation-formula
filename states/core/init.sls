# NOTE: Systemd is not available during bootstrap. Keep states simple!

include:
  - .locale
  - .timezone
  - .network
  - .pacman
  - .update
  - .users
  - .wheel
  - .salt-call
