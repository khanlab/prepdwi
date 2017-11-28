#!/bin/bash

#note: need install anaconda first

if [ -e $HOME/.profile ]; then #ubuntu
	PROFILE=$HOME/.profile
elif [ -e $HOME/.bash_profile ]; then #centos
	PROFILE=$HOME/.bash_profile
else
	echo "..."
	exit 0
fi

#install afni
wget -O- http://neuro.debian.net/lists/xenial.us-nh.full | sudo tee /etc/apt/sources.list.d/neurodebian.sources.list
sudo apt-key adv --recv-keys --keyserver hkp://pool.sks-keyservers.net:80 0xA5D32F012649A5A9
sudo apt-get update
sudo apt-get install -y --allow-unauthenticated afni

#install fsl
wget -O- http://neuro.debian.net/lists/trusty.de-md.full | sudo tee /etc/apt/sources.list.d/neurodebian.sources.list
sudo apt-key adv --recv-keys --keyserver pgp.mit.edu 2649A5A9
sudo apt-get update
sudo apt-get install -y fsl #this will install atalas too


if [ -e $HOME/.profile ]; then #ubuntu
	PROFILE=$HOME/.profile
elif [ -e $HOME/.bash_profile ]; then #centos
	PROFILE=$HOME/.bash_profile
else
    exit 0
fi

#check if PATH already exist in $PROFILE
if grep -q "source /etc/fsl/5.0/fsl.sh"  $PROFILE #return 0 if exist
then 
	echo "source /etc/fsl/5.0/fsl.sh" in $PROFILE already.
else
	echo "#FSL set-up:" >> $PROFILE
	echo "source /etc/fsl/5.0/fsl.sh" >> $PROFILE
fi


#test installation
echo "testing afni install"
afni --help > /dev/null
if [ $? -eq 0 ]; then
	echo 'SUCCESS'
else
    echo 'FAIL.'
fi

echo "testing fsl install"
fsl5.0-bet2 -h > /dev/null  #fsl5.0-fsl -h always show a gui, use fsl5.0-bet2 instead.
if [ $? -eq 0 ]; then
	echo 'SUCCESS'
else
    echo 'FAIL.'
fi
