{% from "workstation/map.jinja" import workstation with context %}
# This file is managed by salt

base:
  {{ workstation.hostname }}:
    - workstation
    - workstation-local
