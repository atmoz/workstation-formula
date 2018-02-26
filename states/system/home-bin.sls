{{ pillar['home-bin-repo'] }}:
  git.latest:
    - target: /home/{{ pillar['username'] }}/bin
    - user: {{ pillar['username'] }}
