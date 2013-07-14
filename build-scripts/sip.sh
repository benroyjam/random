#!/bin/sh

cd `dirname $0`/../sip/ &&
./build.py clean &&
./build.py prepare &&
python3 configure.py -b /usr/local/bin -d /usr/local/lib64/python3.3/site-packages -e /usr/local/include/python3.3m -v /usr/local/share/sip &&
make clean &&
make -j2 CFLAGS='-O2 -march=native -fPIC' CXXFLAGS='-O2 -march=native -fPIC' &&
sudo make install
