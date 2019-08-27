=================
Usage
=================

The prepdwi pipeline is a BIDS App that has three different levels of analysis: a pre-processing pipeline (`participant`), tractography (`participant2`), and QC report generation (`group`). 

This page describes the command-line arguments for prepdwi and for each level of analysis. For details on the pipeline itself, please see :doc:`pipeline`.

usage::

        prepdwi bids_dir output_dir {participant,group,participant2} <optional arguments>
                  [--participant_label PARTICIPANT_LABEL [PARTICIPANT_LABEL...]]
                  [-w WORK_DIR]  (scratch directory)
                  [--n_cpus NCPUS] (for bedpost, default: 8)

         participant options:
                  [--matching_dwi MATCHING_PATTERN]
                  [--matching_T1w MATCHING_STRING]
                  [--reg_init_participant PARTICIPANT_LABEL]
                  [--grad_coeff_file GRAD_COEFF_FILE]

                  [--no-regT1]
                  [--no-topup]
                  [--no-bedpost]
                  [--no-dke]

         participant2 (probtrack connectivity) options:
                  [--nprobseeds] N (for probtrackx, default: 5000)
              Choose built-in atlas:
                  [--atlas NAME (default: dosenbach)

               Available built-in atlas labels/csv:
                  cort_striatum_midbrain        dosenbach  yeo17  yeo17_striatum  yeo7  yeo7_striatum

               Customize atlas labels:
                  [--atlas_space NAME (MNI152_1mm or MNI152NLin2009cAsym)]
                  [--atlas_label_nii NIFTI]
                  [--atlas_label_csv LABEL_INDEX_CSV]


BIDS requirements
------------------

The prepdwi pipeline requires at least one ``dwi`` image (``nii``/``nii.gz``), in the ``dwi`` folder as per the BIDS standard. A ``json`` sidecar is also required for each DWI nifti, with the ``PhaseEncodingDirection`` and ``EffectiveEchoSpacing`` variables set.  A ``T1w`` nifti (in the ``anat`` subfolder) is also highly recommended, but not required if the ``--no-regT1`` flag is used.  If multiple T1w nifti images exist, only the first one (from alphanumeric sorting) will be used. To specify a particular T1w image to use, you can use the ``--matching-T1w`` option.



Flag description
----------------

General flags
^^^^^^^^^^^^^^^^^^^^^^^^

=========================   =====================         ============================================================================
Flag                        Options                       Description
=========================   =====================         ============================================================================
--participant_label         PARTICIPANT_LABEL             Runs for a subset of subjects 
-w                          WORK_DIR                      Specify scratch folder for temporary files
--n_cpus NCPUS.                                           Number of CPUs to use for parallel steps (e.g. BEDPOST with GNU parallel). Default: 8
=========================   =====================         ============================================================================


Participant level flags
^^^^^^^^^^^^^^^^^^^^^^^^

=========================   =====================         ============================================================================
Flag                        Options                       Description
=========================   =====================         ============================================================================
--matching_dwi              MATCHING_PATTERN                     
--matching_T1w              MATCHING_STRING                     
--reg_init_participant      PARTICIPANT_LABEL             Use this flag to re-run participant level for the subjects with failed registrartoins observed in the group level. Use a subject with good registration to initialize the registartion. The subject ID should match the ID as in the work folder. 
--grad_coeff_file           GRAD_COEFF_FILE               Use the provided gradient coeffient file (Siemens format) for gradient non-linearity correction (disabled otherwise)
--no-regT1                                                Disable rigid registration and resampling of processed DWI to the T1 space 
--no-topup                                                Disable Topup correction (use this if opposite phase encode runs do not exist)
--no-bedpost                                              Disable BEDPOST pre-processing 
--no-dke                                                  Disable DKE Kurtosis map estimation
=========================   =====================         ============================================================================


Participant2 level flags
^^^^^^^^^^^^^^^^^^^^^^^^

=============================   =======================   ============================================================================
Flag                            Options                   Description
=============================   =======================   ============================================================================
--nprobseeds                    N                         Number of seeds for probtrackx, default: 5000
--atlas\ :sup:`1`               dosenbach                 Name of the atlas to use for connectivity. default: dosenbach
    \                           cort_striatum_midbrain    
    \                           dosenbach  yeo17  
    \                           yeo17_striatum  
    \                           yeo7  
    \                           yeo7_striatum                                           
--atlas_space\ :sup:`2`         MNI152_1mm                MNI space where the atlas is defined
    \                           MNI152NLin2009cAsym     
--atlas_label_nii\ :sup:`2`     NIFTI                     Nifti file with labeled ROIs
--atlas_label_csv\ :sup:`2`     LABEL_INDEX_CSV           CSV file with indices and labels (each line as: Label_Name,Label_Number)
=============================   =======================   ============================================================================

\ :sup:`1` flgas for available atlases, 
\ :sup:`2` flags for user defined atlases


Participant Level
------------------

At the participant level the T1 data and DWI data are being pre-processed using the following steps. At the end of preprocessing, it will run FSL DTI fit and generates fractional anisotropy (FA) images and mean diffusivity images and other results from DTI fitting, which can be found in the prepdwi folder.

Denoising and Unringing
^^^^^^^^^^^^^^^^^^^^^^^^

Denoising is performed as the first step of our pipeline. We are using the dwidenoise_ tool in MRtrix_ pipeline to perform the denoising process. After running denoisining the unring_ tool was used to remove the Gibbs ringing artefact in images.

.. _dwidenoise: https://mrtrix.readthedocs.io/en/latest/reference/commands/dwidenoise.html
.. _MRtrix: http://www.mrtrix.org/
.. _unring: https://bitbucket.org/reisert/unring/overview


top-up
^^^^^^^^

topup_ is a FSL tool used for estimating and correcting susceptibility induced distortions in our pipeline. This can be used only if you have reversed phase-encoded pairs of images with distortion going in opposite directions. If not, use --no-topup flag.

.. _topup: https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/topup


Eddy Current Correction
^^^^^^^^^^^^^^^^^^^^^^^^

After running topup, the images are corrected for Eddy_Current_ using the eddy_ tool in FSL.

.. _Eddy_Current: https://en.wikipedia.org/wiki/Eddy_current
.. _eddy: https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/eddy

T1w-T1w template (MNI152_1mm and MNI152NLin2009cAsym) registration
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


BEDPOST (optional)
^^^^^^^^^^^^^^^^^^^
FSL BEDPOSTX performs Markov Chain Monte Carlo sampling to build up distributions on diffusion parameters at each voxel. It creates all the files necessary for running probabilistic tractography. To learn more information about the BEDPOSTX, please visit the FSL_ webpage. The results from the BEDPOSTX can be found at the bedpost folder created after running the participant level.

.. _FSL: https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/FDT/UserGuide


Group Level
-------------------

At the Group Level analysis, prepdwi reads all the processed data in participant level and creates a qulaity report for each subject showing how good the registrations are. You can't run group level for a single subject. Once the group level analysis is completed, you will see a new folder inside the "derrivatives" directory called "reports". There you will see a list of html files for each subject which shows the qulaity of the registration at each process. The failed registrations can be identified if the red contour plots are not overlapping with the template image. For the registration failed cases, you can re-run prepdwi participant level using --reg_init_participant flag.

To use the --reg_init_participant flag, you have to pick a subject which has a successful good registration. Then Prepwi will use that as the initial image to register the images of the subjects you want.

.. code-block:: bash

    singularity run home/singularity/prepdwi_version.img home/project/bids home/project/derrivatives participant --reg_init_participant <subj-ID> 

Or, for Khanlab members

.. code-block:: bash

    bidsBatch prepdwi_version <bids_dir> <output_dir> participant --reg_init_participant <subj-ID>


Here the subject ID should be as same as in the work folder. Not as in the bids folder. If there are multimple session for a subject, the session name will be added as a suffix to the subject ID in the work folder. Therefore you have to use the subject ID as it is in the work folder.

Participant2 Level
--------------------

Runs probtrackx network connectivity between all regions in a given atlas labels file. Uses either can use atlases with the --atlas option, where predefined atlases are defined in the cfg folder;  or can specify a new atlas with the --atlas_* options. Participant2 level generates a connectivity matrix of the averaged fiber density between each ROI in the atlas. This matrix can be found in the prepdwi folder as a csv file. The fiber desity is calculated by averaging the number of connections from each seed volxel to a give target by the number of seeds (default: 5000). Then it is averaged by the number of voxols per ROI. 


.. index::
        pair: Syntax; TOC Tree
