# NOTE: Systemd is not available during bootstrap. Keep states simple!

include:
  - .pacman
  - .update
  - .users
  - .locale
  - .time
  - .wheel
  - .network
