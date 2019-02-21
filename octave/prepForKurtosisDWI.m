function prepForKurtosisDWI ( in_dwi_prefix, out_dwi_prefix)

[out_path,out_name]=fileparts(out_dwi_prefix);

dwi_nii=load_nifti(sprintf('%s.nii.gz',in_dwi_prefix));
bvec=importdata(sprintf('%s.bvec',in_dwi_prefix));
bval=importdata(sprintf('%s.bval',in_dwi_prefix));

B=findBvalShells(bval);
%transpose if needed
%if(size(bvec,2)==3)
%bvec=bvec';
%end

bfuzzy=100;
bval_new=[0];
bvec_new=[0;0;0];
for i=1:length(B)
    
    shell_inds{i}=find(bval<(B(i)+bfuzzy) & bval>(B(i)-bfuzzy)  );
    shell_ndirs(i)=length(shell_inds{i});
    
    shell_bval{i}=bval(shell_inds{i});
    shell_bvec{i}=bvec(:,shell_inds{i});
    
    bval_new=[bval_new,shell_bval{i}];
    
    bvec_new=[bvec_new,shell_bvec{i}];

    shell_bvec_files{i}=sprintf('%s_shell%d.bvec',out_dwi_prefix,i);
    
    %transpose for writing:
    dlmwrite(sprintf('%s_shell%d.bvec',out_dwi_prefix,i),shell_bvec{i}');
    dlmwrite(sprintf('%s_shell%d.bval',out_dwi_prefix,i),shell_bval{i}');
    
end


%average b0s
avgb0=mean(dwi_nii.vol(:,:,:,bval<bfuzzy),4);
vol_size=size(dwi_nii.vol);
dwi_new=zeros(vol_size(1),vol_size(2),vol_size(3),sum(shell_ndirs)+1);

dwi_new(:,:,:,1)=avgb0;

startind=2;
for i=1:length(B)
    dwi_new(:,:,:,startind:startind+shell_ndirs(i)-1)=dwi_nii.vol(:,:,:,shell_inds{i});
    startind=startind+shell_ndirs(i);
end


dwi_nii.vol=dwi_new;
dlmwrite(sprintf('%s.bvec',out_dwi_prefix),bvec_new');
dlmwrite(sprintf('%s.bval',out_dwi_prefix),bval_new');

save_nifti(dwi_nii,sprintf('%s.nii',out_dwi_prefix));

dke_cfg=sprintf('%s.dke_params',out_dwi_prefix);

fid=fopen(dke_cfg,'w+');
fprintf(fid,'%% Created on %s by prepForKurtosisDWI\n',date);
fprintf(fid,'studydir = ''%s'';\n',out_path);
fprintf(fid,'subject_list = {''''};\n');
fprintf(fid,'preprocess_options.format = ''nifti'';\n');
fprintf(fid,'preprocess_options.fn_nii = ''%s.nii'';\n',out_name);
fprintf(fid,'fn_img_prefix = ''rdki'';\n');
fprintf(fid,'bval = [0 %d %d];\n',B);
fprintf(fid,'ndir = [%d %d];\n',shell_ndirs);
fprintf(fid,'idx_1st_img = 1;\n');
fprintf(fid,'Kmin  = 0;\n');
fprintf(fid,'NKmax = 3;\n');
fprintf(fid,'Kmin_final = 0;\n');
fprintf(fid,'Kmax_final = 3;\n');
fprintf(fid,'T = 0;\n');
fprintf(fid,'find_brain_mask_flag = 1;\n');
fprintf(fid,'dki_method.no_tensor = 0;\n');
fprintf(fid,'dki_method.linear_weighting = 1;\n');
fprintf(fid,'dki_method.linear_constrained = 1;\n');
fprintf(fid,'dki_method.nonlinear = 0;\n');
fprintf(fid,'dki_method.linear_violations = 0;\n');
fprintf(fid,'dki_method.robust_option = 0;\n');
fprintf(fid,'dki_method.noise_tolerance = 0.09;\n');
fprintf(fid,'dti_method.dti_flag = 1;\n');
fprintf(fid,'dti_method.dti_only = 0;\n');
fprintf(fid,'dti_method.no_tensor = 0;\n');
fprintf(fid,'dti_method.linear_weighting = 1;\n');
fprintf(fid,'dti_method.b_value = [%d];\n',B);
fprintf(fid,'dti_method.directions = {1:%d};\n',shell_ndirs);
fprintf(fid,'dti_method.robust_option = 0;\n');
fprintf(fid,'dti_method.noise_tolerance = 0.09;\n');
fprintf(fid,'fn_noise = '''';\n');
%fprintf(fid,'fwhm_img = 1.25.*[2 2 2];\n');
fprintf(fid,'fwhm_img = [0 0 0];\n');
fprintf(fid,'fwhm_noise = [0 0 0];\n');
%fprintf(fid,'median_filter_method = 1;\n');
fprintf(fid,'median_filter_method = 0;\n');
fprintf(fid,'map_interpolation_method.flag = 0;\n');
fprintf(fid,'map_interpolation_method.order = 1;\n');
fprintf(fid,'map_interpolation_method.resolution = 1;\n');
fprintf(fid,'fn_gradients = {''%s'',''%s''};\n',shell_bvec_files{1},shell_bvec_files{2});
fprintf(fid,'idx_gradients{1} = [1:%d];\n',shell_ndirs(1));
fprintf(fid,'idx_gradients{2} = [1:%d];\n',shell_ndirs(2));

fclose(fid);

end
