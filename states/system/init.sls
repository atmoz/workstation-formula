include:
  - .salt-call
  - .ntp
  - .yubikey
  - .home-bin
  - .dotfiles

/etc/motd: # Remove file after bootstrap
  file.absent
