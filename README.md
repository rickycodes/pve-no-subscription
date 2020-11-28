[![Build Status](https://travis-ci.org/rickycodes/pve-no-subscription.svg?branch=main)](https://travis-ci.org/rickycodes/pve-no-subscription) ![Shellcheck Status](https://img.shields.io/badge/shellcheck-passing-brightgreen)

# Proxmox VE No-Subscription Removal

This script removes the 'No valid subscription' warning in Proxmox VE 6 and should only be used in test or demo environments. Please consider [buying a subscription](https://www.proxmox.com/en/proxmox-ve/pricing)
and supporting the development of Proxmox VE.

## How to install

#### You can run the removal script one of three ways:

##### 1. Curl

`curl` into a bash or bash like shell (colloquially known as yolo'ing):

```
curl --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/rickycodes/pve-no-subscription/main/no-subscription-warning.sh | sh
```
Do not curl blindly :see_no_evil: [Audit the script before you run it](no-subscription-warning.sh). It's not doing anything terribly surprising, I assure you!

##### 2. Git clone

You can also clone the repo with git and run locally if you prefer, but you'll need `git` (a typical proxmox host doesn't have it):
```
git clone git@github.com:rickycodes/pve-no-subscription.git
cd pve-no-subscription
bash no-subscription-warning.sh
```

##### 3. Direct download

Or, you can download the source directly from one of [the releases](https://github.com/rickycodes/pve-no-subscription/releases/tag/v1.0):
```
wget https://github.com/rickycodes/pve-no-subscription/releases/download/v1.0/source.tar.gz
tar -xf source.tar.gz
bash ./pve-no-subscription/no-subscription-warning.sh
```

## Output

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

This is very likely to break in the future. But as of this writing it works for proxmox v 6.2., 6.3.

## License

MIT License. See the [LICENSE](LICENSE) file for details.
