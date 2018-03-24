{% from "workstation/map.jinja" import workstation with context %}

duplicity: pkg.installed

/root/backup.sh:
  file.managed:
    - source: salt://workstation/files/backup.sh.jinja
    - template: jinja
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
