# Matterbridge Configuration for ALERT/K4NWS
## Purpose
Provide a repository to store how to configure Matterbridge from [github](https://github.com/42wim/matterbridge) to connect with Weather.IM IEM Chat. This chat is not an ALERT service, but we are simply relying on a relay for this. This can fail at any time, provided without warranty. Use must comply with the license agreement defined in this repository.

## How to install
### Get the VM Set Up.
1. Get a Linux VM with internet access. Ensure it is fully updated on the latest LTS release of Ubuntu, or appropriate Debian distribution, to stay with this guide. Document your work, keep the passwords stored securely and in a location accessible to the ALERT IT Group.
2. Brute force attacks no VM Servers is a very real thing. Appropriately harden the Linux installation. [See potential guide](https://www.digitalocean.com/community/tutorials/how-to-harden-openssh-on-ubuntu-20-04). In essence, ensure that authentication is based on certificate rather than password. Create sudo logins, allow SSH for those logins, and disable ssh for root login. Arrange for some kind of update cadence, to address any CVE's that might come up. Understand the security risk surface: While this VM is likely not going to store sensitive nonpublic info, you never want a rogue VM using Slack or XMPP credentials on ALERT's behalf.

3. REVIEW/UPDATE [releases](https://github.com/42wim/matterbridge/releases/), if new versions exist, and and run the `INSTALL.sh` script.
*Always pre-review curl-bash scripts, for security! They can change, no matter how much you trust the repository.
`curl -O https://raw.githubusercontent.com/nz2o/K4NWS-bot-relay/main/PREINSTALL.sh | bash`

### Create your configuration files.
4. Configure the matterbridge.toml file, and place it in `/etc/matterbridge/matterbridge.toml`. See this repository's example configuration for a better idea of what needs to happen.
5. Slack bot setup also has to happen here, using [this guide](https://github.com/42wim/matterbridge/wiki/Slack-bot-setup#bot-based-setup).


### Prepare a somewhat secure environment, set permissions.
5. Create a user that the daemon will run as. `sudo useradd -r matterbridge` or something like `sudo adduser --system --no-create-home --group matterbridge` depending on which Linux you're running.
6. Set owner to the new user. Example `sudo chown -R matterbridge:matterbridge /srv/matterbridge` and `sudo chown -R matterbridge:matterbridge /etc/matterbridge`
7. Make the binary executable. `sudo chmod 777 /srv/matterbridge/matterbridge.1.24.1-linux-64bit`. Doesn't matter if everyone can run it, the magic is in the configuration files.
8. Secure your configuration. `sudo chmod -R 660 /etc/matterbridge`. Failure to secure this to just the Matterbridge service account is a no-no, because it contains credentials.

### Pre-flight Check.
9. To exec manually, `./matterbridge -conf '/etc/matterbridge/matterbridge.toml'` if you followed the above.
10. Let's make a SYSTEMD service! Use [this guide](https://github.com/42wim/matterbridge/wiki/Service-files). See example in repository.
