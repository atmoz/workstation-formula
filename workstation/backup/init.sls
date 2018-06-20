{% from "workstation/map.jinja" import workstation with context %}

duplicity: pkg.installed

/usr/local/sbin/backup.sh:
  file.managed:
    - source: salt://workstation/backup/backup.sh
    - template: jinja
    - user: root
    - group: root
    - mode: 700

/usr/local/sbin/backup-notify.sh:
  file.managed:
    - source: salt://workstation/backup/backup-notify.sh
    - template: jinja
    - user: root
    - group: root
    - mode: 700

{% for excluded in workstation.backup.exclude_dirs %}
{% if salt['file.directory_exists' ](excluded) %}
{{ excluded }}/.no-backup:
  file.managed:
    - replace: False
{% endif %}
{% endfor %}
