#!/bin/bash

if [ "$#" -lt 1 ];then
	echo "Usage: $0 <install folder (absolute path)>"
	echo "For sudoer recommend: $0 /opt"
	echo "For normal user recommend: $0 $HOME/app"
	exit 0
fi

echo -n "installing Matrix3..." #-n without newline

DEST=$1
mkdir -p $DEST

D_DIR=$DEST/mrtrix3
if [ -d $D_DIR ]; then
	rm -rf $D_DIR
fi

apt-get update && apt-get install -y libeigen3-dev zlib1g-dev libqt4-opengl-dev libgl1-mesa-dev libfftw3-dev libtiff5-dev

#from git clone
#git clone https://github.com/MRtrix3/mrtrix3.git $D_DIR/matrix3
#cd $D_DIR
#./configure
#./build

#from release
VERSION=3.0_RC2
wget https://github.com/MRtrix3/mrtrix3/archive/${VERSION}.zip; unzip -o ${VERSION}.zip -d ~/temp;rm ${VERSION}.zip
mv ~/temp/mrtrix3-3.0_RC2 $D_DIR
cd $D_DIR
./configure
./build
./set_path
cd

PROFILE=~/.bashrc

#if grep -xq "PATH=$D_DIR/bin:\$PATH" $PROFILE #return 0 if exist
#then 
# 	echo "PATH=$D_DIR/bin" in the PATH already.
#else
# 	./set_path
#fi

source $PROFILE

#test installation
# mrview -h >/dev/null
# if [ $? -eq 0 ]; then
# 	echo 'SUCCESS.'
# 	echo 'To update PATH of current terminal: source ~/.profile'
# 	echo 'To update PATH of all terminal: re-login'
	
# else
#     echo 'FAIL.'
# fi

