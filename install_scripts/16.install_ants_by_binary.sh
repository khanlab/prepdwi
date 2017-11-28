#!/bin/bash

if [ "$#" -lt 1 ]
then
echo "Usage: $0 <install folder (absolute path)>"
exit 0
fi

DEST=$1
mkdir -p $DEST
D_DIR=$DEST/ants

if [ -d $D_DIR ]; then
	rm -rf $D_DIR
fi
mkdir -p $D_DIR

curl -L --retry 5 https://www.dropbox.com/s/thsul5xigqes7tz/Ants_2.1.0_Linux_Ubuntu14.04.tar.bz2?dl=0 | tar jx -C $D_DIR --strip-components=1


if [ -e $HOME/.profile ]; then #ubuntu
	PROFILE=$HOME/.profile
elif [ -e $HOME/.bash_profile ]; then #centos
	PROFILE=$HOME/.bash_profile
else
	echo "Add PATH manualy: PATH=$D_DIR"
	exit 0
fi

#check if PATH already exist in $PROFILE
if grep -xq "export PATH=$D_DIR:\$PATH" $PROFILE #return 0 if exist
then 
	echo "PATH=$D_DIR" in the PATH already.
else
	#create init script
    echo "" >> $PROFILE
    echo "#ants" >> $PROFILE
	echo "export PATH=$D_DIR:\$PATH" >> $PROFILE
	echo "export ANTSPATH=$D_DIR" >> $PROFILE
fi

#test installation
source $PROFILE

#test installation
ants.sh -h >/dev/null
if [ $? -eq 0 ]; then
	echo "SUCCESS"
	echo "To update PATH of current terminal: source $PFORFILE"
	echo "To update PATH of all terminal: re-login"
else
    echo 'FAIL.'
fi
