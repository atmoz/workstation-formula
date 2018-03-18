include:
  - .ntp
  - .yubikey
  - .cli
  - .binfiles
  - .dotfiles

/etc/motd: # Remove file after bootstrap
  file.absent
