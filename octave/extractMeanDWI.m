function extractMeanDWI ( in_dwi_prefix, shell,out_mean_dwi_nii)



dwi_nii=load_nifti(sprintf('%s.nii.gz',in_dwi_prefix));
bvec=importdata(sprintf('%s.bvec',in_dwi_prefix));
bval=importdata(sprintf('%s.bval',in_dwi_prefix));

threshold=50;
dw_inds=bval>(shell-threshold) & bval < (shell+threshold);

dwi_nii.vol=mean(dwi_nii.vol(:,:,:,dw_inds),4);
dwi_nii.dim(5)=1;


save_nifti(dwi_nii,out_mean_dwi_nii);

end
