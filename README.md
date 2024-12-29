# Matterbridge Configuration for ALERT/K4NWS
## Purpose
Provide a repository to store how to configure Matterbridge from [github](https://github.com/42wim/matterbridge) to connect with Weather.IM IEM Chat. This chat is not an ALERT service, but we are simply relying on a relay for this. This can fail at any time, provided without warranty. Use must comply with the license agreement defined in this repository.

## How to install
We're assuming you're either root, or can use sudo before each command.

### Get the VM Set Up.
1. Get a Linux VM with internet access. Ensure it is fully updated on the latest LTS release of Ubuntu, or appropriate Debian distribution, to stay with this guide. Document your work, keep the passwords stored securely and in a location accessible to the ALERT IT Group.
2. Brute force attacks no VM Servers is a very real thing. Appropriately harden the Linux installation. [See potential guide](https://www.digitalocean.com/community/tutorials/how-to-harden-openssh-on-ubuntu-20-04). In essence, ensure that authentication is based on certificate rather than password. Create sudo logins, allow SSH for those logins, and disable ssh for root login. Arrange for some kind of update cadence, to address any CVE's that might come up. Understand the security risk surface: While this VM is likely not going to store sensitive nonpublic info, you never want a rogue VM using Slack or XMPP credentials on ALERT's behalf.

3. REVIEW/UPDATE [releases](https://github.com/42wim/matterbridge/releases/), if new versions exist, and and run the `INSTALL.sh` script.
*Always pre-review curl-bash scripts, for security! They can change, no matter how much you trust the repository.
```
bash -c "$(wget -qLO - https://raw.githubusercontent.com/nz2o/K4NWS-bot-relay/main/PREINSTALL.sh)"
```

### Create your configuration files.
4. Configure the [matterbridge.toml](https://github.com/nz2o/K4NWS-bot-relay/blob/main/VM/etc/matterbridge/matterbridge.toml) file, and place it in `/etc/matterbridge/matterbridge.toml`. See this repository's example configuration for a better idea of what needs to happen.
```
nano /etc/matterbridge/matterbridge.toml
```

5. Slack bot setup also has to happen here, using [this guide](https://github.com/42wim/matterbridge/wiki/Slack-bot-setup#bot-based-setup). Note that you might have to tweak oauth scopes, because Slack chose to go granular.

### Pre-flight Check.
9. To exec manually, `./matterbridge -conf '/etc/matterbridge/matterbridge.toml'` if you followed the above.
10. Let's make a SYSTEMD service! Use [this guide](https://github.com/42wim/matterbridge/wiki/Service-files). See example in repository.
