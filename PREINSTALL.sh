#!/bin/bash
# Title : Pre-configuation for ALERT Slack Matterbridge Relay
# Author: Casey Benefield (casey @t TheBenefields.net)
# Notes : It is expected that you review this, and update version numbers accordingly in this script. Script expects a brand new VM.
#         Scripted Install, no error correction.
VERSION=0.1.0
SUBJECT=K4NWS-bot-matterbridge

# Create paths
mkdir /srv/matterbridge
mkdir /etc/matterbridge
mkdir /var/log/matterbridge

# Grab the binary, make a symbolic link
wget -P /srv/matterbridge/ https://github.com/42wim/matterbridge/releases/download/v1.26.0/matterbridge-1.26.0-linux-64bit
ln -s /srv/matterbridge/matterbridge.1.26.0-linux-64bit /bin/matterbridge

# Create Skeleton configuration file
touch /etc/matterbridge/matterbridge.toml

# Create user and group, group may fail, but it's ok if already exists.
adduser matterbridge
addgroup matterbridge

# Set owners
chown -R matterbridge:matterbridge /srv/matterbridge
chown -R matterbridge:matterbridge /etc/matterbridge

# Set Permissions
chmod a+x /srv/matterbridge/matterbridge-1.26.0-linux-64bit
chmod 650 /etc/matterbridge/matterbridge.toml
