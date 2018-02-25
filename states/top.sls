base:
  '*':
    - core

  'nodename:{{ pillar['hostname'] }}':
    - match: grain
    - dev
    - browser
