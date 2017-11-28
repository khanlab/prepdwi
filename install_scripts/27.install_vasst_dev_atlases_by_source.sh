#!/bin/bash

if [ "$#" -lt 1 ];then
	echo "Usage: $0 <install folder (absolute path)>"
	echo "For sudoer recommend: $0 /opt"
	echo "For normal user recommend: $0 $HOME/app"
	exit 0
fi



INSTALL=$1
mkdir -p $INSTALL


#currently retrieving from dropbox -- update this later to use OSF 
curl -L --retry 5 https://www.dropbox.com/s/q8l2ap16s5so2ct/atlases.tar | tar x -C $INSTALL
curl -L --retry 5  https://www.dropbox.com/s/1lwo3ff91fvx5mj/atlases_tractPatch.tar | tar x -C $INSTALL

