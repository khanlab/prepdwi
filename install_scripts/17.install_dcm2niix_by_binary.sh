#!/bin/bash

if [ "$#" -lt 1 ]
then
echo "Usage: $0 <install folder (absolute path)>"
exit 0
fi

INSTALL=$1
mkdir -p $INSTALL

D_DIR=$INSTALL
mkdir -p $D_DIR

#todo: the is a 'i agree' button, before downloading.
#curl -L http://www.nitrc.org/frs/download.php/9855/${ASHS_NAME}.zip | unzip -d ${INSTALL}

#install software
RANDOM_TEMP=${RANDOM}
wget https://www.dropbox.com/s/elg1t4fm3zp4qxg/mricrogl_linux.zip?dl=0 -O ${RANDOM_TEMP}.zip;unzip -o ${RANDOM_TEMP}.zip -d ${D_DIR}; rm ${RANDOM_TEMP}.zip

if [ -e $HOME/.profile ]; then #ubuntu
	PROFILE=$HOME/.profile
elif [ -e $HOME/.bash_profile ]; then #centos
	PROFILE=$HOME/.bash_profile
else
	echo "Add PATH manualy: PATH=$D_DIR/mricrogl_lx"
	exit 0
fi

#check if PATH already exist in $PROFILE
if grep -xq "export PATH=$D_DIR/mricrogl_lx:\$PATH" $PROFILE #return 0 if exist
then 
	echo "PATH=$D_DIR/mricrogl_lx" in the PATH already.
else
	echo "" >>$PROFILE
    echo "#dcm2niix" >>$PROFILE
	echo "export PATH=$D_DIR/mricrogl_lx:\$PATH" >> $PROFILE    
fi

#test installation
source $PROFILE
dcm2niix -h
if [ $? -eq 0 ]; then
	echo "SUCCESS"
	echo "To update PATH of current terminal: source $PFORFILE"
	echo "To update PATH of all terminal: re-login"
else
    echo "FAIL."
fi
