#!/bin/bash

if [ "$#" -lt 1 ];then
	echo "Usage: $0 <install folder (absolute path)>"
	echo "For sudoer recommend: $0 /opt"
	echo "For normal user recommend: $0 $HOME/app"
	exit 0
fi


DEST=$1
mkdir -p $DEST

D_DIR=$DEST/unring
if [ -d $D_DIR ]; then
	rm -rf $D_DIR
fi

echo -n "installing unring ..." #-n without newline
UNRING_DIR=$D_DIR

SRC=$UNRING_DIR/src

git clone https://bitbucket.org/reisert/unring.git $SRC

BIN=$UNRING_DIR/bin
mkdir -p $BIN

#move precompiled binary to final location
if [ -e $SRC/fsl/unring.a64 ]
then
 cp -v $SRC/fsl/unring.a64 $BIN/unring
else
 echo "Binary $SRC/fsl/unring.a64 does not exist for unring!"
 echo "Cannot complete install.."
 exit 1
fi


PROFILE=~/.bashrc

if grep -xq "PATH=$BIN:\$PATH" $PROFILE #return 0 if exist
then 
 	echo "PATH=$BIN" in the PATH already.
else
 	echo "export PATH=$BIN:\$PATH" >> $PROFILE
fi

source $PROFILE
