clc;
clear;
load jobman.mat

nii_dir='/DATA/231/sz_fmri/DATA_prep_3mm/with_GR_s';

jobman.roi2roi=0;
jobman.roi2wb=1;

jobman.mask={'/DATA/231/sz_fmri/PKU6/corr_map/test/ROIS/rThalamus_HO_AAL_3mm.nii'};
jobman.rois= {'/DATA/238/yyang/MatlabToolbox/Brat/template/fmaskEPI_V3mm.nii'};

jobman.input_nifti.nm_pos=1;
jobman.input_nifti.filetype='*.nii.gz';
jobman.input_nifti.is4d=1;
jobman.out_dir={'/DATA/231/sz_fmri/PKU6/corr_map/Thu_Brain_partial'};
jobman.outputP=0;

tmp=dir(fullfile(nii_dir));
tmp=tmp(cell2mat({tmp.isdir}));
tmp=tmp(~strcmp({tmp.name},'.') & ~strcmp({tmp.name},'..'));
nii_name={tmp.name}';
nii_file=cellfun(@(x) fullfile(nii_dir,x),nii_name,'UniformOutput',false);
jobman.input_nifti.dirs=nii_file;

%brat_roi_script(jobman);
brat_roi_script_partial(jobman);
