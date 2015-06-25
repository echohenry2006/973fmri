clc;
clear;
load jobman.mat

jobman.roi2roi=0;
jobman.roi2wb=1;
jobman.mask={'/DATA/231/sz_fmri/PKU6/corr_map/test/ROIS/rThalamus_HO_AAL_3mm.nii'};
jobman.rois= {'/DATA/231/sz_fmri/PKU6/corr_map/test/ROIS/brain_lobe_6.nii'};
jobman.input_nifti.nm_pos=1;
jobman.input_nifti.filetype='*.nii.gz';

jobman.input_nifti.is4d=1;
jobman.out_dir={'/DATA/231/sz_fmri/PKU6/corr_map/test/'};
jobman.outputP=0;

jobman.input_nifti.dirs={'/DATA/231/sz_fmri/DATA_prep_3mm/with_GR_s/SZ_01_0068/'};

brat_roi_script(jobman);
brat_roi_script_partial(jobman);