# workstation-formula

![Using SaltStack](salt.png)

## Bootstrap

* Boot into Arch Linux installation ISO
* Copy secret pillar data `workstation.sls.gpg` to current dir
* Import public key: `gpg --keyserver pgp.mit.edu --receive-keys 0xB9FB68F98F88BA47`
* Download and verify: `curl -L bootstrap.atmoz.net | gpg -d > bootstrap`
* Run: `bash bootstrap`

## Post install updates

* Run wrapper script `salt-call` (handles encrypted pillar secrets)

