===============
Citing Prepdwi
===============

alik: started jotting down more details, will clean up soon.. -- may be nice to keep this bulleted list (with code references) in addition to a paragraph format

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
 


Prepdwi is mainly using the FSL\ :sup:`1,2,3` tools to preprocess the DTI data. Denoising of the images are performed using the "denoise" tool in MRtrix() and the unrining is performed using the unring\ :sup:`10` tool. 

During the topup process, the data collected with reversed phase-encoded pairs of images with distortion going in opposite directions the susceptibility-induced off-resonance field was estimated using a method similar to that described in Andersson 2003\ :sup:`5`, as implemented in FSL and the two images were combined into a single corrected one.

For Eddy current correction we used the FSL Eddy tool which is based on Jesper 2016\ :sup:`4,11` 

BEDPOSTX\ :sup:`7,8` in FSL was used to prepare data for probabilistic tractography.



Prepdwi also uses octave\ :sup:`9` in numerical analysis within our pipeline.
We have also used Jsonlab\ :sup:`12` tool box.




1. M.W. Woolrich, S. Jbabdi, B. Patenaude, M. Chappell, S. Makni, T. Behrens, C. Beckmann, M. Jenkinson, S.M. Smith. Bayesian analysis of neuroimaging data in FSL. NeuroImage, 45:S173-86, 2009

2. S.M. Smith, M. Jenkinson, M.W. Woolrich, C.F. Beckmann, T.E.J. Behrens, H. Johansen-Berg, P.R. Bannister, M. De Luca, I. Drobnjak, D.E. Flitney, R. Niazy, J. Saunders, J. Vickers, Y. Zhang, N. De Stefano, J.M. Brady, and P.M. Matthews. Advances in functional and structural MR image analysis and implementation as FSL. NeuroImage, 23(S1):208-19, 2004

3. M. Jenkinson, C.F. Beckmann, T.E. Behrens, M.W. Woolrich, S.M. Smith.  FSL. NeuroImage, 62:782-90, 2012

4. Jesper L. R. Andersson and Stamatios N. Sotiropoulos. An integrated approach to correction for off-resonance effects and subject movement in diffusion MR imaging. NeuroImage, 125:1063-1078, 2016. 

5. J.L.R. Andersson, S. Skare, J. Ashburner How to correct susceptibility distortions in spin-echo echo-planar images:application to diffusion tensor imaging. NeuroImage, 20(2):870-888, 2003.

7. T.E.J. Behrens, M.W. Woolrich, M. Jenkinson, H. Johansen-Berg, R.G. Nunes, S. Clare, P.M. Matthews, J.M. Brady, and S.M. Smith. Characterization and propagation of uncertainty in diffusion-weighted MR imaging. Magn Reson Med, 50(5):1077-1088, 2003.

8. T.E.J. Behrens, H. Johansen-Berg, S. Jbabdi, M.F.S. Rushworth, and M.W. Woolrich. Probabilistic diffusion tractography with multiple fibre orientations. What can we gain? NeuroImage, 23:144-155, 2007.

9. John W. Eaton, David Bateman, Søren Hauberg, Rik Wehbring (2015).

10. Kellner, E, Dhital B., Kiselev VG and Reisert, M. Gibbs‐ringing artifact removal based on local subvoxel‐shifts. Magnetic resonance in medicine, 76(5),1574-1581.

11. Jesper L. R. Andersson, Mark S. Graham, Eniko Zsoldos and Stamatios N. Sotiropoulos. Incorporating outlier detection and replacement into a non-parametric framework for movement and distortion correction of diffusion MR images. NeuroImage, 141:556-572, 2016.


License information
====================



Other relevant references
-------------------------

12. https://github.com/fangq/jsonlab

.. index::
        pair: Syntax; TOC Tree
