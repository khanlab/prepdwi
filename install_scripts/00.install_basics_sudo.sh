#!/bin/bash

apt-get update

apt-get install -y --no-install-recommends apt-utils

#basic
apt-get install -y sudo wget curl git dos2unix tree zip unzip

#
apt-get install -y make cmake 

#avoid interactive configureing tdata when installing afni when running 10.install_afni_fsl_sudo.sh
apt-get install -y tzdata
echo "America/New_York" | sudo tee /etc/timezone && sudo dpkg-reconfigure --frontend noninteractive tzdata

#needed when install Anaconda2
apt-get install -y bzip2

#needed when install nipype
apt-get install -y build-essential libtool autotools-dev automake autoconf

#needed when run itksnap
apt-get install -y libglu1-mesa libsm6 libxt-dev libglib2.0-dev libqt5x11extras5

#needed when install dcm4che
#apt-get install -y default-jre

#needed when run freesurfer
apt-get install -y libqt4-scripttools libqt4-dev libjpeg62

#needed when run elastix
#apt-get install -y ocl-icd-opencl-dev

#need when install minc
apt-get install -y imagemagick

#needed when install camino
apt-get install -y openjdk-9-jdk-headless

#needed when install niftyreg
apt-get install -y cmake-curses-gui curl libpng16-dev zlib1g-dev

#needed for bedpostx-parallel (vasst-dev)
apt-get install -y parallel

#needed for QAtools (also requires imagemagick
apt-get install -y gawk 
