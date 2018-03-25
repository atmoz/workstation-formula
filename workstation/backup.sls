{% from "workstation/map.jinja" import workstation with context %}

duplicity: pkg.installed

/root/backup:
  file.recurse:
    - source: salt://workstation/files/backup
    - include_pat: "*.sh"
    - user: root
    - group: root
    - file_mode: 700

/root/backup/conf.sh:
  file.managed:
    - source: salt://workstation/files/backup/conf.sh.jinja
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
