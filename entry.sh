#!/bin/bash

echo "root:hunter123" | chpasswd
echo "me:hunter123" | chpasswd
usermod -aG sudo me
sudo -u me touch /home/me/.sudo_as_admin_successful

mount --bind toolchain theos/toolchain

cp ~/.{bashrc,profile} ~me
chown me:me ~me/.{bashrc,profile}
echo 'export THEOS=~/theos' >> .bashrc
echo 'export PATH="${THEOS}/bin:/home/me/host-swift/usr/bin:${PATH}"' >> .bashrc

cd work
sudo -u me bash -l || :
