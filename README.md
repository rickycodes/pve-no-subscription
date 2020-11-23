# Proxmox VE No-Subscription Removal

This script removes the 'No valid subscription' warning in Proxmox VE 6 and should only be used in test or demo environments. Please consider [buying a subscription](https://www.proxmox.com/en/proxmox-ve/pricing)
and supporting the development of Proxmox VE.

## How to install

```
curl --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/rickycodes/pve-no-subscription/main/no-subscription-warning.sh | sh
```
Do not curl blindly :see_no_evil:

[Audit the script before you run it](no-subscription-warning.sh)

If all goes well you'll see something like:
```
subscription status: NotFound
performing replacement in /usr/share/perl5/PVE/API2/Subscription.pm...
restarting services...
all done!
```

Running the script a second time will give you:
``` 
cannot find item. have you already run the replacement?
```

## Notes

I couldn't get the install steps in [https://github.com/lnxbil/pve-no-subscription](https://github.com/lnxbil/pve-no-subscription) to work properly and [discovered this](https://github.com/lnxbil/pve-no-subscription/issues/5#issue-671298084).

This script is a result of that discovery.
