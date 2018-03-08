Steps:

0.1mm smoothing, flipping,  0.7 Threshold chosen to provide a liberal labelling that is smooth and symmetric



manual labelling: VTA_SNc_2018_02_01.nii.gz
smoothed with 1mm Gaussian: VTA_SNc_2018_02_01_sm1.nii.gz
flipped L-R: VTA_SNc_2018_02_01_sm1_flipX.nii.gz
avg of flipped and unflipped (symmetrize):  VTA_SNc_2018_02_01_sm1_avgFlip.nii.gz
thresholded at 0.7
multiplied by 100: VTA_SNc_smooth.nii.gz
binarized: VTA_SNc_structural.nii.gz

