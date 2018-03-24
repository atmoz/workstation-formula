{% from "workstation/map.jinja" import workstation with context %}

dev-packages:
  pkg.installed:
    - pkgs:
      - gvim         # Vim with extras (like clipboard)
      - openssh      # SSH client
      - gephi        # The Open Graph Viz Platform
      - gdb          # The GNU Debugger
      - git          # The stupid content tracker
      - ghc          # Haskell compiler
      - jdk8-openjdk # Java
      - fzf          # Command-line fuzzy finder
      - pandoc       # Converting different formats
      - ranger       # Vim-like file manager
      - ncdu         # Disk usage analyzer
