include:
  - .salt-call
  - .ntp
  - .yubikey
  - .dotfiles

/etc/motd: # Remove file after bootstrap
  file.absent
