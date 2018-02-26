root:
  user.present:
    - password: {{ pillar['users']['root']['password'] }}

{{ pillar['username'] }}:
  group.present: []
  user.present:
    - password: {{ pillar['users'][pillar['username']]['password'] }}
    - gid: {{ pillar['username'] }}
    - groups:
      - wheel
      - uucp

