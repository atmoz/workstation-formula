{% from "workstation/map.jinja" import workstation with context %}
# This file is managed by salt

base:
  '{{ workstation.hostname }}':
    - workstation.core
    - workstation.system
    - workstation.browser
    - workstation.dev
    - workstation.wm
    - workstation.backup

  'devproxy':
    - devproxy.core
    - devproxy.dev
    - devproxy.wm

  'carbon':
    - atmoz-net
