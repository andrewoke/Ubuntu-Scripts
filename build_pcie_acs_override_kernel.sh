#!/bin/sh

sudo apt-get install kernel-package libncurses5-dev libssl-dev 

mkdir linux
cd linux

wget https://cdn.kernel.org/pub/linux/kernel/v4.x/linux-4.4.tar.xz
tar -xJf linux-4.4.tar.xz

cd linux-4.*

cp /boot/config-$(uname -r) .config

wget https://gist.githubusercontent.com/andrewoke/b362fcea1f612f9b9d80/raw/982b5cb3cab891eac538352c1cde1b6db939a97b/override_for_missing_acs_capabilities.patch

patch -p1 < override_for_missing_acs_capabilities.patch

make menuconfig

make-kpkg clean

fakeroot make-kpkg --initrd --revision=4.4.ACS kernel_image kernel_headers -j 4
