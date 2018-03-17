# salt-laptop

![Using SaltStack](salt.png)

## Bootstrap

* Boot into Arch Linux installation ISO
* Copy `laptop-pillar-secrets.gpg` to current dir
* Import public key, e.g. `curl https://keybase.io/atmoz/pgp_keys.asc | gpg --import`
* Download and verify: `curl -L bootstrap.atmoz.net | gpg -d > bootstrap`
* Run: `sh bootstrap`

## Post install updates

* Run wrapper script `salt-call` (handles encrypted pillar secrets)

