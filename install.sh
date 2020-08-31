#!/bin/bash

#####################################
### Install a Towalink Controller ###
#####################################

# Written for Debian (Buster) and Alpine Linux
#
# The Towalink Project
# Author: Dirk Henrici
# Creation: August 2020
# Last update: August 2020
# License: AGPL3

set -eu
printf "### Welcome to Towalink ###\n"

# Install required packages
printf "\n# Making sure that 'git' and 'Ansible' are installed...\n"
if [ -e "/sbin/apk" ]; then # Alpine (apk-based)
  apk add ansible git
else # non-Alpine
  apt-get -y install ansible git
fi

# Get Ansible playbook
printf "\n# Making sure that current Ansible playbook is downloaded...\n"
mkdir -p /opt/towalink
if [ -d /opt/towalink/ansible ]; then
  cd /opt/towalink/ansible
  git pull
else
  git clone "https://github.com/towalink/controller_install" /opt/towalink/ansible
fi

# Run Ansible playbook
printf "\n# Running Ansible...\n"
ANSIBLE_NOCOWS=1 ansible-playbook /opt/towalink/ansible/local.yml $@
