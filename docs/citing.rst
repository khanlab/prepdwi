===============
Citing Prepdwi
===============

All structural and diffusion data were processed and analyzed using an open-source and containerized application, ``prepdwi``, which uses the BIDS [1] and BIDS Apps [2] standards to perform standardized pre-processing, fitting, image registration, and tractography.



T1w images were skull-stripped using ``bet`` (FSL, using the ``-f 0.4 -B`` options, [3]), corrected for non-uniformities ``N4BiasFieldCorrection`` (ANTS, [4]), and normalized by the mean intensity within the brain mask. Pre-processed T1w images were registered with standard templates (MNI ICBM152 non-linear 6th generation symmetric template, referred to as ``MNI152_1mm`` in FSL, and the ``MNI152NLin2009cAsym`` template) using an initial affine registration using block-matching [5], followed by deformable b-spline registration [6], both implemented in NiftyReg v1.3.9. Overlay visualizations depicting the skull-stripping, affine registration, and deformable registration were generated for each subject to check for failures. Failures in affine registration could occur, but were corrected by forcing initialization with an existing transformation matrix. Discrete and probabilistic segmentation images in the template spaces were automatically propagated to each subject’s T1w space, using nearest neighbour interpolation for discrete segmentations, and linear for probabilistic segmentations.


Diffusion-weighted MRI data were pre-processed with denoising using a local PCA method with (``dwidenoise`` from mrtrix3, [7]), and correction of ringing artifacts with the ``unring`` tool [8]. Eddy current distortions were corrected using ``eddy`` (FSL, [9]), with the ``--repol`` option enabled for outlier replacement [10]. If multiple phase-encoding polarities were used in the acquisition, ``top-up`` [11]was used to correct for susceptibility distortions, with the resulting parameters fed into eddy. If data were not sufficient to run ``top-up``, a registration-based susceptibility distortion correction was performed following ``eddy``, using B-spline deformable registration [6] between the average b0 image and a T1w volume with inverted intensities. Finally, within-subject rigid registration of the corrected DWI volume and the T1w volume was performed using block-matching[5], to bring the DWI images in the same space as the T1w, where atlas labels were also propagated. If gradient non-linearities were provided through spherical harmonic coefficients (e.g. for the AC84 gradient system on the 7T), these were used with the ``gradient_unwarp`` tool [12] to generate a non-linear transformation, which was composed with the T1w linear transformation to resample the DWI images into the corrected T1w space in a single step. Modulation with the determinant of the Jacobian of the unwarping was used to correct for intensity differences in the magnitude images due to gradient non-linearities. Pre-processed DWI images in the T1w space were then used to estimate diffusion tensor metrics using ``dtifit`` (FSL, [13]), and ball and stick modelling for probablistic tractography using ``bedpostx`` [14]. If multi-shell diffusion data was detected, diffusion kurtosis metrics were computed using the DKE toolbox [15].

------------
References:
------------

1. 	Gorgolewski KJ, Auer T, Calhoun VD, Craddock RC, Das S, Duff EP, et al. The brain imaging data structure, a format for organizing and describing outputs of neuroimaging experiments. Sci Data. 2016;3: 160044. doi:10.1038/sdata.2016.44
2. 	Gorgolewski KJ, Alfaro-Almagro F, Auer T, Bellec P, Capotă M, Chakravarty MM, et al. BIDS apps: Improving ease of use, accessibility, and reproducibility of neuroimaging data analysis methods. PLoS Comput Biol. 2017;13: e1005209. doi:10.1371/journal.pcbi.1005209
3. 	Smith SM. Fast robust automated brain extraction. Hum Brain Mapp. 2002;17: 143–155. doi:10.1002/hbm.10062
4. 	Tustison NJ, Avants BB, Cook PA, Zheng Y, Egan A, Yushkevich PA, et al. N4ITK: improved N3 bias correction. IEEE Trans Med Imaging. 2010;29: 1310–1320. doi:10.1109/TMI.2010.2046908
5. 	Modat M, Cash DM, Daga P, Winston GP, Duncan JS, Ourselin S. Global image registration using a symmetric block-matching approach. J Med Imaging (Bellingham). 2014;1: 024003. doi:10.1117/1.JMI.1.2.024003
6. 	Modat M, Ridgway GR, Taylor ZA, Lehmann M, Barnes J, Hawkes DJ, et al. Fast free-form deformation using graphics processing units. Comput Methods Programs Biomed. 2010;98: 278–284. doi:10.1016/j.cmpb.2009.09.002
7. 	Veraart J, Novikov DS, Christiaens D, Ades-Aron B, Sijbers J, Fieremans E. Denoising of diffusion MRI using random matrix theory. Neuroimage. 2016;142: 394–406. doi:10.1016/j.neuroimage.2016.08.016
8. 	Kellner E, Dhital B, Kiselev VG, Reisert M. Gibbs-ringing artifact removal based on local subvoxel-shifts. Magn Reson Med. 2016;76: 1574–1581. Available: https://onlinelibrary.wiley.com/doi/abs/10.1002/mrm.26054
9. 	Andersson JLR, Sotiropoulos SN. An integrated approach to correction for off-resonance effects and subject movement in diffusion MR imaging. Neuroimage. 2016;125: 1063–1078. doi:10.1016/j.neuroimage.2015.10.019
10. 	Andersson JLR, Graham MS, Zsoldos E, Sotiropoulos SN. Incorporating outlier detection and replacement into a non-parametric framework for movement and distortion correction of diffusion MR images. Neuroimage. 2016;141: 556–572. doi:10.1016/j.neuroimage.2016.06.058
11. 	Andersson JLR, Skare S, Ashburner J. How to correct susceptibility distortions in spin-echo echo-planar images: application to diffusion tensor imaging. Neuroimage. 2003;20: 870–888. doi:10.1016/S1053-8119(03)00336-7
12. 	Jovicich J, Czanner S, Greve D, Haley E, van der Kouwe A, Gollub R, et al. Reliability in multi-site structural MRI studies: effects of gradient non-linearity correction on phantom and human data. Neuroimage. 2006;30: 436–443. doi:10.1016/j.neuroimage.2005.09.046
13. 	Jenkinson M, Beckmann CF, Behrens TEJ, Woolrich MW, Smith SM. FSL. Neuroimage. 2012;62: 782–790. doi:10.1016/j.neuroimage.2011.09.015
14. 	Behrens TEJ, Woolrich MW, Jenkinson M, Johansen-Berg H, Nunes RG, Clare S, et al. Characterization and propagation of uncertainty in diffusion-weighted MR imaging. Magn Reson Med. 2003;50: 1077–1088. doi:10.1002/mrm.10609
15. 	Tabesh A, Jensen JH, Ardekani BA, Helpern JA. Estimation of tensors and tensor-derived measures in diffusional kurtosis imaging. Magn Reson Med. 2011;65: 823–836. Available: https://onlinelibrary.wiley.com/doi/abs/10.1002/mrm.22655



#versions:
neuroglia-dwi:latest
mrtrix 3.0_RC3
camino 2019-02-01 1c4ef77615d103d43adcff6c79b72d0bbdac0897
unring 2017-02-17
dke v1.0 
niftyreg 1.3.9
fsl v6.0 (fslinstaller 3.0.12)



.. 
    Text and references copied from google doc with paperpile here:
    https://docs.google.com/document/d/1gHi9FABuYr6NY4BB_uoBhSuNuSWP85cRrkcKGlJz7GI/edit?usp=sharing


.. index::
        pair: Syntax; TOC Tree
