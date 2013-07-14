#!/bin/sh

if [[ $UID -ne 0 ]]; then
	sudo "$0"
	exit 0
fi

cd /usr/src/linux/
make distclean &&
cp `dirname $0`/kernel/3.10-nvidia.config ./.config &&
make -j2 &&
make modules_install &&
make install &&
make clean &&
(ln -s /usr/src/linux/include/generated/uapi/linux/version.h /usr/src/linux/include/linux/version.h || :)
