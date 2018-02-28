# Bootstrap

* Boot into Arch Linux installation ISO
* Copy `laptop-pillar-secrets.gpg` to current dir (you know where to find it)
* Import public key, e.g. `curl https://keybase.io/atmoz/pgp_keys.asc | gpg --import`
* Download and verify: `curl -L bootstrap.atmoz.net | gpg -d > bootstrap`
* Inspect (and modify): `vim bootstrap`
* Run: `sh bootstrap`

# Post install updates

* Run wrapper script `/srv/salt/salt-call` (handles encrypted secrets)
