hostname: atmoz-laptop

users:
  root:
    password: secret
  atmoz:
    password: secret

pacman:
  mirrorlist: |
    Server = http://archlinux.uib.no/$repo/os/$arch
    Server = http://mirror.f4st.host/archlinux/$repo/os/$arch
    Server = http://mirror.bytemark.co.uk/archlinux/$repo/os/$arch
    Server = http://ftp.portlane.com/pub/os/linux/archlinux/$repo/os/$arch
    Server = http://www.mirrorservice.org/sites/ftp.archlinux.org/$repo/os/$arch
