[![Build Status](https://travis-ci.org/rickycodes/pve-no-subscription.svg?branch=main)](https://travis-ci.org/rickycodes/pve-no-subscription) ![Shellcheck Status](https://img.shields.io/badge/shellcheck-passing-brightgreen)

# Proxmox VE No-Subscription Removal

This script removes the 'No valid subscription' warning in Proxmox VE 6 and should only be used in test or demo environments. Please consider [buying a subscription](https://www.proxmox.com/en/proxmox-ve/pricing)
and supporting the development of Proxmox VE.

## How to install

```
curl --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/rickycodes/pve-no-subscription/main/no-subscription-warning.sh | sh
```
Do not curl blindly :see_no_evil:

[Audit the script before you run it](no-subscription-warning.sh)

You can also clone the repo with git and run locally if you prefer:
```
git clone git@github.com:rickycodes/pve-no-subscription.git
cd pve-no-subscription
bash no-subscription-warning.sh
```

After a successful run, you should see the following result:
```
subscription status: NotFound
performing replacement in /usr/share/perl5/PVE/API2/Subscription.pm...
restarting services...
all done!
```

Running the script a second time will produce the following result:
``` 
cannot find item. have you already run the replacement?
```

Running the script on a non pve install will produce:
```
/usr/share/perl5/PVE/API2/Subscription.pm does not exist! are you sure this is pve?
```

## Notes

I couldn't get the install steps in [https://github.com/lnxbil/pve-no-subscription](https://github.com/lnxbil/pve-no-subscription) to work properly and [discovered this](https://github.com/lnxbil/pve-no-subscription/issues/5#issue-671298084).

This script is a result of that discovery.
