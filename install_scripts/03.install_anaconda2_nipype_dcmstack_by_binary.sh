#!/bin/bash

if [ "$#" -lt 1 ];then
	echo "Usage: $0 <install folder (absolute path)>"
	echo "For sudoer recommend: $0 /opt"
	echo "For normal user recommend: $0 $HOME/app"
	exit 0
fi

echo -n "installing anaconda2..." #-n without newline

DEST=$1
mkdir -p $DEST

ANACONDA2_DIR=$DEST/anaconda2
if [ -d $ANACONDA2_DIR ]; then
	rm -rf $ANACONDA2_DIR
fi

apt-get install -y bzip2

INST_FILE=Anaconda2-4.2.0-Linux-x86_64.sh
#-P: prefix, where there file will be save to
wget -P $ANACONDA2_DIR --tries=10 https://repo.continuum.io/archive/$INST_FILE 
#-b:bacth mode, -f: no error if install prefix already exists
bash $ANACONDA2_DIR/$INST_FILE -b -f -p $ANACONDA2_DIR
rm $ANACONDA2_DIR/$INST_FILE

#wget --tries=10 -q -O - https://repo.continuum.io/archive/$INST_FILE | bash - -b -p $ANACONDA2_DIR

if [ -e $HOME/.profile ]; then #ubuntu
	PROFILE=$HOME/.profile
elif [ -e $HOME/.bash_profile ]; then #centos
	PROFILE=$HOME/.bash_profile
else
	echo "Add PATH manualy: PATH=$ANACONDA2_DIR/bin"
	exit 0
fi

#check if PATH already exist in $PROFILE
if grep -xq "export PATH=$ANACONDA2_DIR/bin:\$PATH" $PROFILE #return 0 if exist
then 
	echo "PATH=$ANACONDA2_DIR/bin" in the PATH already.
else
	echo "" >> $PROFILE    
	echo "#anaconda2" >> $PROFILE    
	echo "export PATH=$ANACONDA2_DIR/bin:\$PATH" >> $PROFILE    
fi

#install hedconv dependencies:
#	pydicom #installed when install nipype 
#	nipype  #installed by my script
#	nibabel #installed when install nipype
#	dcmstack #pip install 
source $PROFILE
conda install -y -c conda-forge nipype 
pip install --upgrade pip
pip install https://github.com/moloney/dcmstack/archive/c12d27d2c802d75a33ad70110124500a83e851ee.zip

#test installation
echo "test anaconda install: "
conda update conda -y > /dev/null
if [ $? -eq 0 ]; then
	echo 'SUCCESS'
	echo "To update PATH of current terminal: source $PFORFILE"
	echo "To update PATH of all terminal: re-login"
else
    echo 'FAIL.'
fi

##update pip(sometimes need newer version of pip)
#$(which conda) install pip -y