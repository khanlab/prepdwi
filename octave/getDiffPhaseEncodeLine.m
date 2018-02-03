function getDiffPhaseEncodeLine (in_bids_nii,out_txt)
%octave
%dependencies: jsonlab, load_nifti

%nii=load_nifti('sub-0061_dwi_multiband_acq-RL.nii.gz');


hdr=load_nifti(in_bids_nii,0);
json=loadjson([in_bids_nii(1:(end-7)) '.json']);
%'sub-0061_dwi_multiband_acq-RL.nii.gz');

imsize=hdr.dim(2:4);

switch json.PhaseEncodingDirection(1) 
  case 'i'
  vec=[1,0,0];
  case 'j'
  vec=[0,1,0];
  case 'k'
  vec=[0,0,1];
  
end

numPhaseEncodes=imsize(find(vec));

%check + or -
if (length(json.PhaseEncodingDirection)==2)
   if (json.PhaseEncodingDirection(2) == '-');
   vec(find(vec))=-1;
  end
  end
  
phenc_line=[vec, json.EffectiveEchoSpacing.*numPhaseEncodes];
dlmwrite(out_txt,phenc_line,' ');

  
