{% from "workstation/map.jinja" import workstation with context %}

dev-packages:
  pkg.installed:
    - pkgs:
      - base-devel   # make, etc ...
      - htop         # Interactive process viewer
      - gvim         # Vim with extras (like clipboard)
      - neovim       # NeoVim
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
      - keybase      # CLI tool for GPG with keybase.io
      - kbfs         # The Keybase filesystem
      - python-pylint # Analyzes Python code
      - dstat        # A versatile resource statistics tool
