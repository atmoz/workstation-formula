yubikey-gpg-deps:
  pkg.installed:
    - pkgs:
      - libusb-compat
      - ccid

pcscd:
  service.running:
    - enable: true
    - require:
      - pkg: pcslite
