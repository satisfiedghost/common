#!/bin/bash
# Appends common hostnames
# You must be root to run this

echo "Appending hostnames in \'additional_hosts\` to /etc/hosts"
sudo cat additional_hosts >> /etc/hosts
