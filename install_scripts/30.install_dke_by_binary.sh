#!/bin/bash

if [ "$#" -lt 1 ]
then
echo "Usage: $0 <install folder (absolute path)>"
exit 0
fi

INSTALL=$1
mkdir -p $INSTALL

D_DIR=$1/dke
if [ -d $D_DIR ]; then
	rm -rf $D_DIR
fi
mkdir -p $D_DIR

#install MCR v717 (dependency)
TMP_DIR=/tmp/mcr
MCR_DIR=$INSTALL/mcr/v717
mkdir -p $MCR_DIR
MCR_DIR=`realpath $MCR_DIR`


echo "MCR_DIR=$MCR_DIR"
mkdir -p $TMP_DIR $MCR_DIR
curl -L --retry 5 http://ssd.mathworks.com/supportfiles/MCR_Runtime/R2012a/MCR_R2012a_glnxa64_installer.zip  > $TMP_DIR/install.zip
pushd $TMP_DIR
unzip install.zip
./install -mode silent -agreeToLicense yes -destinationFolder $MCR_DIR
popd

rm -rf $TMP_DIR


#install dke
RANDOM_TEMP=${RANDOM}
wget https://www.dropbox.com/s/trnelcwppyrlibf/Linux64.zip?dl=0 -O ${RANDOM_TEMP}.zip;unzip -o ${RANDOM_TEMP}.zip -d $D_DIR; rm ${RANDOM_TEMP}.zip

#install dke fiber tracking module
RANDOM_TEMP=${RANDOM}
wget https://www.dropbox.com/s/mvagskpbt75ah31/Linux_FT.zip?dl=0 -O ${RANDOM_TEMP}.zip;unzip -o ${RANDOM_TEMP}.zip -d $D_DIR; rm ${RANDOM_TEMP}.zip


#add additional layer of wrappers to include mcr path:
for tool in dke dke_ft dke_preprocess_dicom map_interpolate
do
 mv $D_DIR/run_$tool.sh $D_DIR/base_$tool.sh
echo "MCR_DIR=$MCR_DIR"
 echo "$D_DIR/base_$tool.sh $MCR_DIR \$@" > $D_DIR/run_$tool
 chmod a+x $D_DIR/run_$tool $D_DIR/base_$tool.sh $D_DIR/$tool
done



echo $HOME

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
	printf "\n#dke\n" >> $PROFILE    
	echo "export PATH=$D_DIR:\$PATH" >> $PROFILE    
fi


# #test installation
# source $PROFILE
# ashs_main.sh -h 
# if [ $? -eq 0 ]; then
# 	echo 'SUCCESS'
# 	echo "To update PATH of current terminal: source $PFORFILE"
# 	echo "To update PATH of all terminal: re-login"
# else
#     echo 'FAIL.'
# fi
