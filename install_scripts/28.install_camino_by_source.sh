#!/bin/bash

if [ "$#" -lt 1 ];then
	echo "Usage: $0 <install folder (absolute path)>"
	echo "For sudoer recommend: $0 /opt"
	echo "For normal user recommend: $0 $HOME/app"
	exit 0
fi


DEST=$1

D_DIR=$DEST/camino
if [ -d $D_DIR ]; then
 echo removing dir
	rm -rf $D_DIR
fi

CAMINO_DIR=$D_DIR
mkdir -p $D_DIR

#release from: https://sourceforge.net/projects/camino
HASH=9cf8bef17561e88d730df3bc6a8bc111ed1d93aa
VERSION=2017.10.06 
URL=https://downloads.sourceforge.net/project/camino/camino-code-$HASH.zip

#In MBs -- make this larger if you are running out of java virtual memory
HEAPSIZE=12000


echo -n "installing Camino $VERSION ..." #-n without newline
curl -L --retry 5 $URL -o $CAMINO_DIR/camino-code-$HASH.zip


pushd $CAMINO_DIR
unzip camino-code-$HASH.zip
mv  camino-code-$HASH/* .
make
popd

PROFILE=~/.bashrc

if grep -xq "PATH=$CAMINO_DIR/bin:\$PATH" $PROFILE #return 0 if exist
then 
 	echo "PATH=$CAMINO_DIR/bin" in the PATH already.
else
 	echo "export PATH=$CAMINO_DIR/bin:\$PATH" >> $PROFILE
	echo "export LD_LIBRARY_PATH=$CAMINO_DIR/lib:\$LD_LIBRARY_PATH" >> $PROFILE
	echo "export MANPATH=$CAMINO_DIR/man:\$MANPATH" >> $PROFILE
	echo "export CAMINO_HEAP_SIZE=$HEAPSIZE"  >> $PROFILE

fi

source $PROFILE

