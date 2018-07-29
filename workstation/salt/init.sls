{% from "workstation/map.jinja" import workstation with context %}

/etc/salt/minion_id:
  file.managed:
    - contents: {{ workstation.hostname }}
    - user: root
    - group: root
    - mode: 700

/etc/salt/minion:
  file.managed:
    - source: salt://workstation/salt/templates/salt/minion
    - template: jinja
    - user: root
    - group: root
    - mode: 700

/etc/salt/master:
  file.managed:
    - source: salt://workstation/salt/templates/salt/master
    - template: jinja
    - user: root
    - group: root
    - mode: 700

/etc/salt/roster:
  file.managed:
    - contents: {{ workstation.salt.roster | yaml_encode }}
    - template: jinja
    - user: root
    - group: root
    - mode: 700

/srv/salt/top.sls:
  file.managed:
    - source: salt://workstation/salt/templates/salt/top.sls
    - template: jinja
    - user: root
    - group: root
    - mode: 700

/srv/pillar/top.sls:
  file.managed:
    - source: salt://workstation/salt/templates/pillar/top.sls
    - template: jinja
    - user: root
    - group: root
    - mode: 700

/usr/local/bin/salt-call:
  file.managed:
    - source: salt://workstation/salt/templates/salt-call
    - template: jinja
    - user: root
    - group: root
    - mode: 700
