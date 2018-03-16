include:
  - .ntp
  - .yubikey
  - .cli
  - .dotfiles

/etc/motd: # Remove file after bootstrap
  file.absent
