# Bootstrap

* Boot arch linux installation ISO
* Copy `laptop-pillar-secrets.gpg` (you know where to find it) to current dir
* Download: `curl -L bootstrap.atmoz.net > bootstrap`
* Verify: `less bootstrap`
* Run: `chmod +x bootstrap && ./bootstrap`

# Post install updates

* Run wrapper script `/srv/salt/salt-call` (handles encrypted secrets)
