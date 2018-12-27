{% from "workstation/map.jinja" import workstation with context %}

lxc:
  pkg.installed

##############################################################################
# Enable unprivileged containers
# https://wiki.archlinux.org/index.php/Linux_Containers#Enable_support_to_run_unprivileged_containers_(optional)
##############################################################################

/etc/sysctl.d/unprivileged_userns_clone.conf:
  file.managed:
    - contents: "kernel.unprivileged_userns_clone=1"

/etc/pam.d/system-login:
  file.append:
    - text: "session optional pam_cgfs.so -c freezer,memory,name=systemd,unified"

/etc/lxc/default.conf:
  file.append:
    - text:
      - "lxc.idmap = u 0 100000 65536"
      - "lxc.idmap = g 0 100000 65536"

/etc/subuid:
  file.append:
    - text: "root:100000:65536"

/etc/subgid:
  file.append:
    - text: "root:100000:65536"

##############################################################################
