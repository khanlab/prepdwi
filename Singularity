Bootstrap: docker
From: khanlab/neuroglia-dwi:v1.3.2


%labels
Maintainer "Ali Khan"

#########
%setup
#########
mkdir -p $SINGULARITY_ROOTFS/opt/prepdwi
cp -Rv . $SINGULARITY_ROOTFS/opt/prepdwi


#########
%post
#########


echo addpath\(genpath\(\'/opt/prepdwi/octave\'\)\)\; >> /etc/octave.conf 
apt-get install -y bc

#########
%environment
#########

export PATH=/opt/prepdwi/bin:$PATH

#########
%runscript
#########

exec /opt/prepdwi/prepdwi $@


