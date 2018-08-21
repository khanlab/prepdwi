========
Prepdwi Pipeline
========

Prepdwi has three level of analysis named as participant, group and participant2.

usage::

        prepdwi bids_dir output_dir {participant,group,participant2} <optional arguments>
                  [--participant_label PARTICIPANT_LABEL [PARTICIPANT_LABEL...]]
                  [--matching_dwi MATCHING_PATTERN]
                  [--matching_T1w MATCHING_STRING]
                  [--reg_init_participant PARTICIPANT_LABEL]
                  [--grad_coeff_file GRAD_COEFF_FILE]
                  [-w WORK_DIR]  (scratch directory)

                  [--no-regT1]
                  [--no-topup]
                  [--no-bedpost]
                  [--no-dke]
                  [--n_cpus NCPUS] (for bedpost, default: 8)

         participant2 (probtrack connectivity) options:
                  [--nprobseeds] N (for probtrackx, default: 5000)
              Choose built-in atlas:
                  [--atlas NAME (default: dosenbach)

               Available built-in atlas labels/csv:
                  cort_striatum_midbrain        dosenbach  yeo17  yeo17_striatum  yeo7  yeo7_striatum

               Customize atlas labels:
                  {--atlas_space NAME (MNI152_1mm or MNI152NLin2009cAsym)
                  [--atlas_label_nii NIFTI
                  [--atlas_label_csv LABEL_INDEX_CSV    


Participant Level
----------------

At the participant level the T1 data and DWI data are being pre-processed using the following steps.

Denoising and unringing
^^^^

top-up
^^^^

Eddy Current Correction
^^^^

T1w-T1w template (MNI152_1mm and MNI152NLin2009cAsym) registration
^^^^


BEDPOST
^^^^



Group Level
-------------------

At the Group Level analysis, prepdwi reads all the processed data in participant level and creates a qulaity report for each subject showing how good the registrations are. You can't run group level for a single subject. Once the group level analysis is completed, you will see a new folder inside the "derrivatives" directory called "reports". There you will see a list of html files for each subject which shows the qulaity of the registration at each process. The failed registrations can be identified if the red contour plots are not overlapping with the template image. For the registration failed cases, you can re-run prepdwi participant level using --reg_init_participant flag.

To use the --reg_init_participant flag, you have to pick a subject which has a successful good registration. Then Prepwi will use that as the initial image to register the images of the subjects you want.

.. code-block:: bash

    singularity run home/singularity/prepdwi_7g home/project/bids home/project/derrivatives participant --reg_init_participant <subj-ID> 

Or, for Khanlab members

.. code-block:: bash

    bidsBatch prepdwi_0.0.7g <bids_dir> <output_dir> participant --reg_init_participant <subj-ID>


Here the subject ID should be as same as in the work folder. Not as in the bids folder. If there are multimple session for a subject, the session name will be added as a suffix to the subject ID in the work folder. Therefore you have to use the subject ID as it is in the work folder.

Participant2 Level
--------------------

Runs probtrackx network connectivity between all regions in a given atlas labels file. Uses either canned atlases with the --atlas option, where predefined atlases are defined in the cfg folder;  or can specify a new atlas with the --atlas_* options


.. index::
        pair: Syntax; TOC Tree