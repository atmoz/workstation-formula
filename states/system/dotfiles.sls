salt://system/dotfiles-init.sh:
  cmd.script:
    - cwd: /home/{{ pillar['username'] }}
    - runas: {{ pillar['username'] }}
    - creates: /home/{{ pillar['username'] }}/.dotfiles
