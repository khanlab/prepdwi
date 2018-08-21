Bootstrap: shub
From: akhanf/vasst-dev:v0.0.3a


%labels
Maintainer "Ali Khan"



#########
%setup
#########
mkdir -p $SINGULARITY_ROOTFS/src
cp -Rv . $SINGULARITY_ROOTFS/src


#########
%post
#########


%runscript
exec /src/prepdwi $@
