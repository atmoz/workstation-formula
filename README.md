# Bootstrap

* Boot into Arch Linux installation ISO
* Copy `laptop-pillar-secrets.gpg` to current dir (you know where to find it)
* Download: `curl -L bootstrap.atmoz.net > bootstrap`
* Verify: `less bootstrap`
* Run: `sh bootstrap`

# Post install updates

* Run wrapper script `/srv/salt/salt-call` (handles encrypted secrets)
