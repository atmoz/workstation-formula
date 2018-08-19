{% from "workstation/map.jinja" import workstation with context %}

duplicity: pkg.installed

b2:
  pip.installed:
    - require:
      - pkg: python-pip

/usr/local/sbin/backup.sh:
  file.managed:
    - source: salt://workstation/backup/files/backup.sh
    - template: jinja
    - user: root
    - group: root
    - mode: 700

/usr/local/sbin/backup-notify.sh:
  file.managed:
    - source: salt://workstation/backup/files/backup-notify.sh
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
