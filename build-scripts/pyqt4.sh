#!/bin/sh

cd `dirname $0`/../PyQt/PyQt-x11-gpl-4.10.1/ &&
(sudo ln -s /usr/include/dbus-1.0/dbus/dbus-python-3.3.h /usr/include/dbus-1.0/dbus/dbus-python.h || :) &&
env QMAKESPEC=/usr/lib64/qt5/mkspecs/linux-g++/ env QTDIR=/usr/local/lib64/qt5 python3 configure.py --confirm-license --no-deprecated --no-designer-plugin -s /usr/include/dbus-1.0 -b /usr/local/bin -d /usr/local/lib64/python3.3/site-packages -v /usr/local/share/sip &&
make clean &&
make -j2 CFLAGS='-O2 -march=native -fPIC' CXXFLAGS='-O2 -march=native -fPIC' && (
	(sudo mkdir -p /usr/local/lib64/python3.3/site-packages/PyQt4/ || :) &&
	(sudo mkdir -p /usr/local/share/sip || :) &&
	(sudo mkdir -p /usr/local/share/sip/QtCore || :) &&
	(sudo mkdir -p /usr/local/share/sip/QtGui || :) &&
	(sudo mkdir -p /usr/local/share/sip/QtNetwork || :) &&
	(sudo mkdir -p /usr/local/share/sip/QtDBus || :) &&
	(sudo mkdir -p /usr/local/share/sip/QtOpenGL || :) &&
	(sudo mkdir -p /usr/local/share/sip/QtSql || :) &&
	(sudo mkdir -p /usr/local/share/sip/QtTest || :) &&
	(sudo mkdir -p /usr/local/share/sip/QtXml || :) &&
	(sudo mkdir -p /usr/local/share/sip/Qt || :) &&
	(sudo mkdir -p /usr/local/lib64/python3.3/site-packages/PyQt4/uic || :) &&
	(sudo mkdir -p /usr/local/lib64/python3.3/site-packages/PyQt4/uic/port_v2 || :) &&
	(sudo mkdir -p /usr/local/lib64/python3.3/site-packages/PyQt4/uic/Loader || :) &&
	(sudo mkdir -p /usr/local/lib64/python3.3/site-packages/PyQt4/uic/port_v3 || :) &&
	(sudo mkdir -p /usr/local/lib64/python3.3/site-packages/PyQt4/uic/Compiler || :) &&
	(sudo mkdir -p /usr/local/lib64/python3.3/site-packages/PyQt4/uic/widget-plugins || :)
) &&
sudo make install
