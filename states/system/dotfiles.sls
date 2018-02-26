salt://dotfiles-init.sh:
  cmd.script:
    - template: jinja
    - cwd: /home/{{ pillar['username'] }}
    - runas: {{ pillar['username'] }}
    - creates: /home/{{ pillar['username'] }}/.dotfiles
