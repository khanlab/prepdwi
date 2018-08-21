============
Installation
============

Prepdwi is built into a singularity container which you can easily download an image of it from https://singularity-hub.org/collections/392 

Once you downloaded the latest stable version of prepdwi, follow the steps below to run it.

Install Singularity
########

To run a singularity image, first you need to have singularity installed in your local computer or server. To install singularity, please follow the instructions in the singularity website.

https://www.sylabs.io/guides/2.5.1/user-guide/

Running prepdwi
########

Once the singularity set up in your computer you can start running prepdwi. The following is an example of running prepdwi on a set of BIDS data.

Example
*******

For this example, let's assume that your downloaded singularity image is saved in the path home/singularity/Singularity.0.07g and your BIDS data is saved in home/data/bids. you can rename the image name from Singularity.0.07g to prepdwi_7g for simplicity

The data in the "bids" folder should be in the BIDS format. For moredetails about BIDS format, read:
http://bids.neuroimaging.io/

participant level analysis
---------------------------

In prepdwi, there are several levels of analysis named as participant, group and participant2. To learn more about these analysis levels and optional arguments/flags, read (put a link here)

The basic structure for running prepdwi is:

.. code-block:: bash

	singularity run <path_to_prepdwi_image> <bids_dir> <output_dir> {participant,group,participant2} <optional arguments>

For our example create a directory to save the output inside the project directory as "derrivatives".

At the command line type::

    singularity run home/singularity/prepdwi_7g home/project/bids home/project/derrivatives participant 

Or, if you have access to Khanlab Graham server and have `neuroglia helpers <https://github.com/khanlab/neuroglia-helpers>`_. installed you can submit it as a job.

.. code-block:: bash

    bidsBatch prepdwi_0.0.7g <bids_dir> <output_dir> participant

This will run the participant level analysis for all the subjects in the bids folder and will save the resultst to the derrivatives folder. This code is running the `FSL BEDPOSTX <https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/FDT/UserGuide#BEDPOSTX>`_. which takes a long time and we highly recommend using highspeed computer server to run this code. (Typical time is 24 hours in Sharcnet)
Once the process is completed, you will see a "work" folder and a "prepdwi" folder inside the "derrivatives" directory. To learn what to expect inside thses folders, read (link to the cookbook)


group level analysis
---------------------------

After running the participant level analysis, you can run a group level analysis to see how good the registarions are. To know more about the group level analysis, read (link)


At the command line type::

    singularity run home/singularity/prepdwi_7g home/project/bids home/project/derrivatives group 

Or, for Khanlab members

.. code-block:: bash

	bidsBatch prepdwi_0.0.7g <bids_dir> <output_dir> group

IMPORTANT: Makesure that the ourput directory is the same as the one for "participant" level.

Once the group level analysis is completed, you will see a new folder inside the "derrivatives" directory called "reports". There you will see a list of html files for each subject which shows the qulaity of the registration at each process. The failed registrations can be identified if the red contour plots are not overlapping with the template image. For the registration failed cases, you can re-run prepdwi participant level using --reg_init_participant flag which is explained in the (link to cookbook).

participant2 level analysis
---------------------------

If the participant1 level is completed you can run participant2 level analysis on the data. To know more about participant2 level, read (link)

At the command line type::

    singularity run home/singularity/prepdwi_7g home/project/bids home/project/derrivatives participant2 

Or, for Khanlab members

.. code-block:: bash

	bidsBatch prepdwi_0.0.7g <bids_dir> <output_dir> participant2

IMPORTANT: Makesure that the ourput directory is the same as the one for "participant" level.

Once the participant2 level analysis is completed, you will see a new folder inside the "derrivatives" directory called "bedpost". Also you will see several csv files for connectivity matrix and FA matrices.


  .. index::
        pair: Syntax; TOC Tree