function rotate_bvecs_imgorient (in_bvec_file,  in_xfm,  in_src_nii,  in_dest_nii, out_bvec_file)


bvecs=dlmread(in_bvec_file);

src_hdr=load_nifti(in_src_nii,1);
dest_hdr=load_nifti(in_dest_nii,1);

if (dest_hdr.sform_code~= 1)
    disp(sprintf('Problem to sformcode in %s!',in_dest_nii));
    exit;
end

if (src_hdr.sform_code ~= 1)
    disp(sprintf('Problem to sformcode in %s!',in_src_nii));
    exit;
end

affine=importdata(in_xfm);


dest_sform=dest_hdr.sform;
src_sform=src_hdr.sform;

%get the rotational component only
rot=inv(dest_sform(1:3,1:3))*affine(1:3,1:3)*src_sform(1:3,1:3);


rot_bvecs=rot*bvecs;
dlmwrite(out_bvec_file,rot_bvecs,'delimiter',' ','precision',5);


end

