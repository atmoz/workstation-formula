root:
  user.present:
    - password: {{ pillar['users']['root']['password'] }}

atmoz:
  group.present: []
  user.present:
    - password: {{ pillar['users']['atmoz']['password'] }}
    - gid: atmoz
    - groups:
      - wheel
      - uucp

