{% from "workstation/map.jinja" import workstation with context %}

cpulimit: pkg.installed

firejail: pkg.installed

chromium: pkg.installed

firefox: pkg.installed

/etc/firejail/chromium-common.local:
  file.managed:
    - contents: ignore private-dev

{% for container in workstation.browser.containers %}
/home/{{ workstation.username }}/.firejail-home/chromium/{{ container }}:
  file.directory:
    - user: {{ workstation.username }}
    - group: {{ workstation.username }}
    - makedirs: True
{% endfor %}
