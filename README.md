[![Build Status](https://travis-ci.org/rickycodes/pve-no-subscription.svg?branch=main)](https://travis-ci.org/rickycodes/pve-no-subscription) ![Shellcheck Status](https://img.shields.io/badge/shellcheck-passing-brightgreen)
[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Frickycodes%2Fpve-no-subscription.svg?type=shield)](https://app.fossa.com/projects/git%2Bgithub.com%2Frickycodes%2Fpve-no-subscription?ref=badge_shield)

# Proxmox VE No-Subscription Removal

This script removes the 'No valid subscription' warning in Proxmox VE 6 and should only be used in test or demo environments. Please consider [buying a subscription](https://www.proxmox.com/en/proxmox-ve/pricing)
and supporting the development of Proxmox VE.

## How to install

#### You can run the removal script one of three ways:

##### 1. Curl

`curl` into bash like shell:

```
curl --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/rickycodes/pve-no-subscription/main/no-subscription-warning.sh | sh
```
Do not curl blindly :see_no_evil: [Audit the script before you run it](no-subscription-warning.sh). It's not doing anything terribly surprising, I assure you!

##### 2. With Git

You can also clone the repo with git and run locally if you prefer, but you'll need `git` (a typical proxmox host doesn't have it installed):
```
git clone git@github.com:rickycodes/pve-no-subscription.git
cd pve-no-subscription
bash no-subscription-warning.sh
```

##### 3. Download

Or, you can download the source directly from one of [the releases](https://github.com/rickycodes/pve-no-subscription/releases/tag/v1.0):
```
wget https://github.com/rickycodes/pve-no-subscription/releases/download/v1.0/source.tar.gz
tar -xf source.tar.gz
bash ./pve-no-subscription/no-subscription-warning.sh
```

## Diagnostic

The script provides stdout and verifies a few things on behalf of the user.

#### After a successful run, you should see the following result:
```
subscription status: NotFound
performing replacement in /usr/share/perl5/PVE/API2/Subscription.pm...
restarting services...
all done!
```

#### Running the script a second time will produce the following result:
``` 
cannot find item. have you already run the replacement?
```

#### Running the script on a non pve install will produce:
```
/usr/share/perl5/PVE/API2/Subscription.pm does not exist! are you sure this is pve?
```

## TL;DR

If you don't care about the above diagnostic feedback and you'd rather yolo, this is the gist of it:
```sh
#!/bin/sh
set -ex
sed -i "s/NotFound/Active/g" "/usr/share/perl5/PVE/API2/Subscription.pm"
systemctl restart pvedaemon
systemctl restart pveproxy
```

## Adding apt hook

After updating you may find you need to re-run the script to apply the patch. You can automate this by adding a `Post-Invoke` apt hook.

First, let's create the script to run (you can put these files anywhere, but I am following pve conventions as best I can).

```
touch /usr/share/proxmox-ve/pve-apt-post-hook
```

The above file should look something like this:

```sh
#!/usr/bin/env bash
set -ex
curl --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/rickycodes/pve-no-subscription/main/no-subscription-warning.sh | sh
```

We'll also need to make the file executable:

```
chmod +x /usr/share/proxmox-ve/pve-apt-post-hook
```

Once that's done, we can add the hook. For that we're going to edit an existing file: `/etc/apt/apt.conf.d/10pveapthook`

Add the following line to the above file:

```
DPkg::Post-Invoke { "/usr/share/proxmox-ve/pve-apt-post-hook"; };
```

And that's it! The next time you perform an `apt upgrade` you should see something like the following (if the patch needs to be applied):

```
...
Setting up dnsutils (1:9.11.5.P4+dfsg-5.1+deb10u2) ...
Processing triggers for mime-support (3.62) ...
Processing triggers for libc-bin (2.28-10) ...
Processing triggers for rsyslog (8.1901.0-1) ...
Processing triggers for systemd (241-7~deb10u5) ...
Processing triggers for man-db (2.8.5-2) ...
Processing triggers for initramfs-tools (0.133+deb10u1) ...
update-initramfs: Generating /boot/initrd.img-5.4.34-1-pve
Running hook script 'zz-pve-efiboot'..
Re-executing '/etc/kernel/postinst.d/zz-pve-efiboot' in new private mount namespace..
No /etc/kernel/pve-efiboot-uuids found, skipping ESP sync.
Processing triggers for ca-certificates (20200601~deb10u1) ...
Updating certificates in /etc/ssl/certs...
0 added, 0 removed; done.
Running hooks in /etc/ca-certificates/update.d...
done.
+ sh
+ curl --proto =https --tlsv1.2 -sSf https://raw.githubusercontent.com/rickycodes/pve-no-subscription/main/no-subscription-warning.sh
		status => "NotFound",
subscription status: NotFound
attempting replacement in /usr/share/perl5/PVE/API2/Subscription.pm...
restarting services...
all done!
```

You can see the script ran successfully around the `+ sh` part.

## Notes

I couldn't get the install steps in [pve-no-subscription](https://github.com/lnxbil/pve-no-subscription) to work properly and [discovered this](https://github.com/lnxbil/pve-no-subscription/issues/5#issue-671298084). This script is a result of that discovery.

[pve-nag-buster](https://github.com/foundObjects/pve-nag-buster) does the replacement in the web UI source, but that approach also seems to have stopped working? There's an [issue here](https://github.com/foundObjects/pve-nag-buster/issues/3) with details on how to get around that).

This is very likely to break in the future. But as of this writing it works for proxmox versions `6.2.x` through to `7.3-3`

## License

MIT License. See the [LICENSE](LICENSE) file for details.

[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Frickycodes%2Fpve-no-subscription.svg?type=large)](https://app.fossa.com/projects/git%2Bgithub.com%2Frickycodes%2Fpve-no-subscription?ref=badge_large)
