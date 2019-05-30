{% from "workstation/map.jinja" import workstation with context %}
# This file is managed by salt

base:
  {{ workstation.hostname }}:
    - workstation.core
    - workstation.salt
    - workstation.system
    - workstation.browser
    - workstation.dev
    - workstation.wm
    - workstation.backup
    - workstation.laptop
    - workstation.lxc

  devproxy:
    - devproxy.core
    - devproxy.dev
    - devproxy.wm

  carbon:
    - atmoz-net
