#!/bin/sh

cd `dirname $0`/../sip/sip-4.15.3/ &&
python3 configure.py -b /usr/local/bin -d /usr/local/lib64/python3.3/site-packages -e /usr/local/include/python3.3m -v /usr/local/share/sip &&
make clean &&
make -j2 CFLAGS='-O2 -march=native -pipe -fPIC' CXXFLAGS='-O2 -march=native -pipe -fPIC' &&
sudo make install
