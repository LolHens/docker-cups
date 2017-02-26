#!/bin/bash
#########################################
##  FILES, SERVICES AND CONFIGURATION  ##
#########################################

# Copy files to their places
cd /files && find . -type f -exec cp -f --parents '{}' / \;
chmod -R +x /etc/service /etc/my_init.d

# Disbale some cups backend that are unusable within a container
mv /usr/lib/cups/backend/parallel /usr/lib/cups/backend-available/
mv /usr/lib/cups/backend/serial /usr/lib/cups/backend-available/

# Disable dbus for avahi
sed -i "s|#enable-dbus.*|enable-dbus=no|g" /etc/avahi/avahi-daemon.conf

#########################################
##                 CLEANUP             ##
#########################################

# Clean APT install files
apt-get clean -y
rm -rf /var/lib/apt/lists/* /var/cache/* /var/tmp/*
