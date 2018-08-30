=================
Prepdwi Pipeline
=================

The prepdwi pipeline is a BIDS App that has three different levels of analysis: a pre-processing pipeline (`participant`), tractography (`participant2`), and QC report generation (`group`). 

The pre-processing pipeline aims to produce a filtered and corrected diffusion-weighted image, along with a set of basic quantitative maps, that can then be used for downstream analyses (fitting, tractography, voxel-based analysis, microstructural modelling, and so on). The app is written in BASH, with each step generally written as a separate script, each called by the main  `prepdwi <../prepdwi>`_ script.  A summary of the processing steps is provided here, along with references to the corresponding code. 

T1 pre-processing  (`code <../bin/processT1>`_)
 * Skull-stripping with FSL BET (options: -f 0.4 -B) [cite] 
 * Non-uniformity correction with ANTS N4BiasFieldCorrection [cite]
 * intensity normalization by mean intensity 
 
T1 atlas registration
 * Non-linear registration is performed to obtain transformations to/from the MNI152_1mm and MNI152NLin2009cAsym templates, and transform labels to the subject T1 space
 * The pipeline will perform this step on all templates in the `atlases <../atlases>`_ folder, using the ``t1/t1.brain.inorm.nii.gz`` image to register, and transforming the labels in ``labels/<label_names>`` folders
 * Affine registration is performed with reg_aladin (NiftyReg 1.3.9) `code <../bin/reg_intersubj_aladin>`_
 * Non-linear (b-spline) registration is performed with reg_f3d (NiftyReg 1.3.9) `code <../bin/reg_bspline_f3d>`_
 * Atlas labels from the ``labels`` folders are transformed to the subject T1 space with reg_resample (NiftyReg 1.3.9)  `code <../bin/propLabels_reg_bspline_f3d>`_

DWI pre-processing:
 * DWI Denoising is performed on the raw DWI using dwidenoise (MRtrix3) `code <../bin/processDwiDenoise>`_
 * Removal of Gibb's ringing artifacts was performed with the unring tool  `code <../bin/processUnring>`_
 * If multiple phase-encode directions exist:
        * Susceptibility-induced distortions are corrected with top-up & eddy (FSL)
        * Uses the b02b0 preset on average b0 images and requires JSON flags ``PhaseEncodingDirection`` and ``EffectiveEchoSpacing``, and uses the voxel dimension in the phase encode direction to generate the ``acqp`` file  `code <../bin/processTopUp>`_)
        * Performs eddy-current correction using eddy_openmp, concatenates all scans, --repol to replace outliers  `code <../bin/processEddy>`_)
 * If multiple phase-encode directions do **NOT** exist:
        * Performs eddy-current correction using eddy_openmp, concatenates all scans, --repol to replace outliers  `code <../bin/processEddyNoTopup>`_)
        * Performs non-linear registration (NiftyReg) for EPI distortion correction (uses skull-stripped T1 with inverted intensities, rigidly-registered to the avgB0 as a reference; uses b-spline registration (reg_f3d, -be 0.001), and warps DWI  `code <../bin/processDistortCorrect>`_)
 * Rigid alignment to T1 space (reg_aladin, rotates bvecs, resamples to either specified resolution, or original dwi resolution  `code <../bin/processRegT1>`_ )
 * If a gradient coefficient file exists:
        * Performs gradient unwarping (cubic interp, jacobian modulation, generates grad_dev file, concatenates with DWI-T1 rigid transform  `code <../bin/processGradUnwarp>`_ )
 * Generates mean DWI for each shell ( `code <../octave/extractMeanDWI.m>`_)
 
 
 * FSL BEDPOST 
 * if (multi-shell)
        * DKE fitting 
 * export to BIDS-like output
 
 
etc:
 * BIDS [cite]
 * BIDS-Apps [cite]
 * Docker [cite]
 * Singularity [cite]
 * neuroglia-core/dwi [cite]
 
 
Built-in external atlases:
 * Dosenbach [cite]
 * Yeo7, Yeo17 [ cite ]
 
.. index::
        pair: Syntax; TOC Tree
