#!/bin/bash

if [ "$#" -lt 1 ];then
	echo "Usage: $0 <install folder (absolute path)>"
	echo "For sudoer recommend: $0 /opt"
	echo "For normal user recommend: $0 $HOME/app"
	exit 0
fi

echo -n "installing NiftyReg 1.3.9..." #-n without newline

DEST=$1
mkdir -p $DEST

D_DIR=$DEST/niftyreg
if [ -d $D_DIR ]; then
	rm -rf $D_DIR
fi

NIFTY_VER=1.3.9
NIFTY_SRC=$D_DIR/src
NIFTY_DIR=$D_DIR



mkdir -p $NIFTY_SRC && \
  echo "Downloading http://sourceforge.net/projects/niftyreg/files/nifty_reg-${NIFTY_VER}/nifty_reg-${NIFTY_VER}.tar.gz/download" && \
  curl -L http://sourceforge.net/projects/niftyreg/files/nifty_reg-${NIFTY_VER}/nifty_reg-${NIFTY_VER}.tar.gz/download \
    | tar xz -C $NIFTY_SRC --strip-components 1 && \
mkdir -p $NIFTY_DIR && \
pushd $NIFTY_DIR  && \
cmake $NIFTY_SRC \
    -DCMAKE_BUILD_TYPE=Release \
    -DBUILD_SHARED_LIBS=OFF \
    -DBUILD_TESTING=OFF \
    -DCMAKE_INSTALL_PREFIX=$NIFTY_DIR  && \
  make -j$(nproc) && \
  make install 

PROFILE=~/.bashrc

if grep -xq "PATH=$NIFTY_DIR/bin:\$PATH" $PROFILE #return 0 if exist
then 
 	echo "PATH=$NIFTY_DIR/bin" in the PATH already.
else
 	echo "export PATH=$NIFTY_DIR/bin:\$PATH" >> $PROFILE
	echo "export LD_LIBRARY_PATH=$NIFTY_DIR/lib:\$LD_LIBRARY_PATH" >> $PROFILE
fi

source $PROFILE


