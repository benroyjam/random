#!/bin/sh

cd `dirname $0`/../PyQt/PyQt-gpl-5.0/ &&
(sudo ln -s /usr/include/dbus-1.0/dbus/dbus-python-3.3.h /usr/include/dbus-1.0/dbus/dbus-python.h || :) &&
env QMAKESPEC=/usr/lib64/qt5/mkspecs/linux-g++/ env QTDIR=/usr/local/lib64/qt5 python3 configure.py --confirm-license --no-designer-plugin -q /usr/bin/qmake-qt5 -s /usr/include/dbus-1.0 -b /usr/local/bin -d /usr/local/lib64/python3.3/site-packages -v /usr/local/share/sip --sip-incdir=/usr/local/include/python3.3m &&
make clean &&
make -j2 &&
sudo make install
