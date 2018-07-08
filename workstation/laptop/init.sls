{% from "workstation/map.jinja" import workstation with context %}

#####################################################################
## https://bbs.archlinux.org/viewtopic.php?id=68591
#####################################################################

/etc/modprobe.d/headphones-fix.conf:
  file.managed:
    - contents:
      - alias snd-card-0 snd-hda-intel
      - alias sound-slot-0 snd-hda-intel
      - options snd-hda-intel index=1,0 model=lenovo

