===============
Citing Prepdwi
===============

#versions:
neuroglia-dwi:latest
mrtrix 3.0_RC3
camino 2019-02-01 1c4ef77615d103d43adcff6c79b72d0bbdac0897
unring 2017-02-17
dke v1.0 
niftyreg 1.3.9
fsl v6.0 (fslinstaller 3.0.12)


# draft boilerplate text:


All structural and diffusion data were processed and analyzed using an open-source and containerized application, `prepdwi`, which uses the BIDS [cite BIDS paper] and BIDS Apps [cite BIDS Apps paper] standard to perform standardized pre-processing, fitting, image registration, and tractography.

## T1w pre-processing (*participant*-level)
T1w images were skull-stripped using `bet` [FSL, using the `-f 0.4 -B` options, cite], corrected for non-uniformities `N4BiasFieldCorrection` [ANTS, cite], and normalized by the mean intensity within the brain mask. 
Pre-processed T1w images were registered with standard templates (MNI ICBM152 non-linear 6th generation symmetric template, referred to as `MNI152_1mm` in FSL, and the `MNI152NLin2009cAsym` template) using an initial affine registration, followed by deformable b-spline registration using NiftyReg (v1.3.9, [cite]).
Overlay visualizations depicting the skull-stripping, affine registration, and deformable registration are generated for each subject.
Failures in affine registration were corrected by forcing initialization with an existing transformation matrix. Discrete and probabilistic segmentation images in the template spaces were automatically propagated to each subject's T1w space, using nearest neighbour interpolation for discrete segmentations, and linear for probabilistic segmentations.

## Diffusion pre-processing (*participant*-level)

Diffusion-weighted MRI data were pre-processed with denoising using a local PCA method with `dwidenoise` (mrtrix, [cite]), and correction of ringing artifacts with the `unring` tool [cite]. 
Eddy current distortions were corrected using `eddy` (FSL, [cite]), with the `--repol` option enabled for outlier replacement.  
If multiple phase-encoding polarities were used in the acquisition, `top-up` was used to perform B0 field map correction prior to `eddy`, with the resulting parameters fed into `eddy`. If data were not sufficient to run `top-up`, a registration-based distortion correction was performed following `eddy`, using B-spline deformable registration between the average b0 image and a T1w volume with inverted intensities. 
Finally, within-subject rigid registration of the corrected DWI volume and the T1w volume was performed (NiftyReg), to bring the DWI images in the same space as the T1w, where atlas labels were also propagated.
If gradient non-linearities were provided through spherical harmonic coefficients (e.g. for the AC84 gradient system on the 7T), these were used with the `gradient_unwarp` tool (cite) to generate a non-linear transformation, which was composed with the T1w linear transformation to resample the DWI images into the corrected T1w space in a single step. Modulation with the determinant of the Jacobian of the unwarping was used to correct for intensity differences in the magnitude images due to gradient non-linearities. 
Pre-processed DWI images in the T1w space were then used to estimate diffusion tensor metrics using `dtifit` (FSL [cite]), and ball and stick modelling for probablistic tractography using `bedpostx`. 
If multi-shell diffusion data was detected, diffusion kurtosis metrics were computed using the DKE toolbox (DKE [cite]).


##






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
