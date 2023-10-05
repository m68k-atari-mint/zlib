#!/bin/bash -ex
# -e: Exit immediately if a command exits with a non-zero status.
# -x: Display expanded script commands

# use as build.sh <dest dir> (i.e. the files will be installed to <dest dir>/<sys-root>/usr)

export CFLAGS="$CFLAGS -O2 -fomit-frame-pointer"
export CXXFLAGS="$CXXFLAGS -O2 -fomit-frame-pointer"
export PREFIX="$($TOOL_PREFIX-gcc -print-sysroot)/usr"

export CC=$TOOL_PREFIX-gcc
export AR=$TOOL_PREFIX-ar
export RANLIB=$TOOL_PREFIX-ranlib

export CONFIGURE_FLAGS="$CONFIGURE_FLAGS --prefix=$PREFIX"

./configure $CONFIGURE_FLAGS
make
make install DESTDIR="$1"
make distclean || make clean

CFLAGS="$CFLAGS -m68020-60" CXXFLAGS="$CXXFLAGS -m68020-60" ./configure $CONFIGURE_FLAGS --libdir=$PREFIX/lib/m68020-60
make
make install DESTDIR="$1"
make distclean || make clean

CFLAGS="$CFLAGS -mcpu=5475" CXXFLAGS="$CXXFLAGS -mcpu=5475" ./configure $CONFIGURE_FLAGS --libdir=$PREFIX/lib/m5475
make
make install DESTDIR="$1"
make distclean || make clean
