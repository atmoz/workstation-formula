{% from "workstation/map.jinja" import workstation with context %}

dev-packages:
  pkg.installed:
    - pkgs:
      - gvim         # Vim with extras (like clipboard)
      - openssh      # SSH client
      - gephi        # The Open Graph Viz Platform
      - gdb          # The GNU Debugger
      - git          # The stupid content tracker
      - cmake        # A cross-platform open-source make system
      - go           # Core compiler tools for the Go programming language
      - dep          # Go dependency management tool
      - ghc          # Haskell compiler
      - jdk8-openjdk # Java
      - ack          # A tool like grep, optimized for programmers
      - fzf          # Command-line fuzzy finder
      - pandoc       # Converting different formats
      - ranger       # Vim-like file manager
      - ncdu         # Disk usage analyzer
      - progress     # Shows running coreutils commands and stats
      - pv           # Monitoring the progress of data through a pipeline
      - unrar        # Unzip that zip!
      - shellcheck   # Shell script analysis tool
