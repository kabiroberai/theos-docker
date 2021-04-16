#!/bin/bash

cd ~me

if mkdir /setup_done 2>/dev/null; then
    # perform initial setup
    echo "root:hunter2" | chpasswd
    echo "me:hunter2" | chpasswd
    usermod -aG sudo me
    sudo -u me touch /home/me/.sudo_as_admin_successful

    cp ~/.{bashrc,profile} ~me
    chown me:me ~me/.{bashrc,profile}
    echo 'export THEOS=~/theos' >> .bashrc
    echo 'export PATH="${THEOS}/bin:${PATH}"' >> .bashrc

    apt-get update
fi

mount --bind toolchain theos/toolchain

cd work
sudo -u me bash -l || :
