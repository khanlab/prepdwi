=================
Prepdwi Pipeline
=================


etc:
 * BIDS [cite]
 * BIDS-Apps [cite]
 * Docker [cite]
 * Singularity [cite]
 * neuroglia-core/dwi [cite]
 
T1 pre-processing  `code <../bin/processT1>`_
 * FSL BET skull strip  (options: -f 0.4 -B) [cite] 
 * N4BiasFieldCorrection [cite, from ANTS]
 * intensity normalization by mean intensity 
 
T1 registration
 * NiftyReg 1.3.9 [cite] reg_aladin (affine registration) to template (MNI152_1mm, MNI152NLin2009cAsym)  `code <../bin/reg_intersubj_aladin>`_
 * NiftyReg 1.3.9 reg_f3d (b-spline non-linear registration to templates  `code <../bin/reg_bspline_f3d>`_
 * Transform atlas labels to subject T1 space  `code <../bin/propLabels_reg_bspline_f3d>`_

Built-in external atlases:
 * Dosenbach [cite]
 * Yeo7, Yeo17 [ cite ]

DWI pre-processing:
 * Denoise  `code <../bin/processDwiDenoise>`_
 * Unring  `code <../bin/processUnring>`_
 * if multiple phase-encode dirs:
        * top-up (runs b02b0 preset on average b0 images;  uses JSON: PhaseEncodingDirection, EffectiveEchoSpacing, and voxel dimension in the phase encode direction to get acqp file  `code <../bin/processTopUp>`_)
 * eddy (concatenate all scans, eddy_openmp, --repol to replace outliers  `code <../bin/processEddy>`_)
 * if ~(multiple phase-encode dirs):
        * NiftyReg non-linear registration for EPI distortion correction (uses skull-stripped T1 with inverted intensities, rigidly-registered to the avgB0 as a reference; uses b-spline registration (reg_f3d, -be 0.001), and warps DWI  `code <../bin/processDistortCorrect>`_)
 * Rigid alignment to T1 space (reg_aladin, rotates bvecs, resamples to either specified resolution, or original dwi resolution  `code <../bin/processRegT1>`_ )
 * if (grad coeffs exist)
        * perform gradient unwarping (cubic interp, jacobian modulation, generates grad_dev file, concatenates with DWI-T1 rigid transform  `code <../bin/processGradUnwarp>`_ )
 * generate mean DWI for each shell ( `code <../octave/extractMeanDWI.m>`_)
 * FSL BEDPOST 
 * if (multi-shell)
        * DKE fitting 
 * export to BIDS-like output
 
 
 
.. index::
        pair: Syntax; TOC Tree
