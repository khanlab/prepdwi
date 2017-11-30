Bootstrap: shub
From: akhanf/neuroglia-core

#########
%setup
#########
cp ./install_scripts/*.sh $SINGULARITY_ROOTFS

#########
%post
#########


export DEBIAN_FRONTEND=noninteractive
#bash 00.install_basics_sudo.sh
#bash 03.install_anaconda2_nipype_dcmstack_by_binary.sh /opt
#bash 04.install_octave_sudo.sh 
#bash 10.install_afni_fsl_sudo.sh
#bash 16.install_ants_by_binary.sh /opt
#bash 17.install_dcm2niix_by_binary.sh /opt
#bash 25.install_niftyreg_by_source.sh /opt
bash 21.install_MRtrix3_by_source_sudo.sh /opt
bash 26.install_vasst_dev_by_source.sh /opt
bash 27.install_vasst_dev_atlases_by_source.sh /opt
bash 28.install_camino_by_source.sh /opt
bash 29.install_unring_by_binary.sh /opt
bash 30.install_dke_by_binary.sh /opt

#remove all install scripts
rm *.sh

#########
%environment

#MRtrix3
export PATH=/opt/mrtrix3/bin:$PATH

#vasst-dev
export VASST_DEV_HOME=/opt/vasst-dev
export PIPELINE_ATLAS_DIR=/opt/atlases
export PIPELINE_DIR=$VASST_DEV_HOME/pipeline
export PIPELINE_TOOL_DIR=$VASST_DEV_HOME/tools
MIAL_DEPENDS_DIR=$VASST_DEV_HOME/mial-depends
#MIAL_DEPENDS_LIBS=$VASST_DEV_HOME/mial-depends/lib
#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$MIAL_DEPENDS_LIBS
export PIPELINE_CFG_DIR=$PIPELINE_DIR/cfg
export PATH=$PIPELINE_TOOL_DIR:$MIAL_DEPENDS_DIR:$PATH
export MCRBINS=$VASST_DEV_HOME/mcr/v92
for name in `ls -d $PIPELINE_DIR/*`; do  export PATH=$name:$PATH; done
#mcr - vasst-dev dependency
export MCRROOT=/opt/mcr/v92



#camino
export PATH=/opt/camino/bin:$PATH
export LD_LIBRARY_PATH=/opt/camino/lib:$LD_LIBRARY_PATH
export MANPATH=/opt/camino/lib:$MANPATH
export CAMINO_HEAP_SIZE=32000

#unring
export PATH=/opt/unring/bin:$PATH


#dke
export PATH=/opt/dke:$PATH

%files
#########
run.sh /run.sh

%runscript
exec /run.sh $@
