{% from "workstation/map.jinja" import workstation with context %}

duplicity: pkg.installed

/root/backup:
  file.directory:
    - user: root
    - group: root

/root/backup/conf.sh:
  file.managed:
    - source: salt://workstation/files/backup/conf.sh.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 700

/root/backup/cleanup.sh:
  file.managed:
    - source: salt://workstation/files/backup/cleanup.sh
    - user: root
    - group: root
    - mode: 700

/root/backup/incremental.sh:
  file.managed:
    - source: salt://workstation/files/backup/incremental.sh
    - user: root
    - group: root
    - mode: 700

/root/backup/remove-old.sh:
  file.managed:
    - source: salt://workstation/files/backup/remove-old.sh
    - user: root
    - group: root
    - mode: 700

/root/backup/status.sh:
  file.managed:
    - source: salt://workstation/files/backup/status.sh
    - user: root
    - group: root
    - mode: 700

{% if workstation.backup.exclude_dirs is defined %}
{% for excluded in workstation.backup.exclude_dirs %}
{{ excluded }}/.no-backup:
  file.managed:
    - replace: False
{% endfor %}
{% endif %}
