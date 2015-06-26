
param1={'one_sample_Ttest_NC','one_sample_Ttest_SZ','Ttest'};
param2={'001','002','003','004','005','006'};

for i=1:length(param1)
    for j=1:length(param2)
%         clear;
%         clc;
        
        load jobman.mat
        input_type = {'voxel'};
        
        jobman.out_dir= {strcat('/DATA/238/yyang/workspace/973_FMRI/Thu_Brain/',param1{i},'/',param2{j},'/meta/')};
        
        jobman.mask= {'/DATA/238/yyang/workspace/973_FMRI/Thu_Brain/rThalamus_HO_AAL_3mm.nii'};
        jobman.input_nifti.filetype='*.img';
        jobman.input_nifti.dirs = {strcat('/DATA/238/yyang/workspace/973_FMRI/Thu_Brain/',param1{i},'/',param2{j},'/meta/')};
        
        switch param1{i}
		case 'one_sample_Ttest_NC'
			xls='/oo_info_ttest_NC.xlsx'
     		case 'one_sample_Ttest_SZ'
			xls='/oo_info_ttest_SZ.xlsx'
		case 'Ttest'
			xls='/oo_info_ttest2.xlsx'
            
        end
        jobman.num_subjs_tbl= {strcat('/DATA/238/yyang/workspace/973_FMRI/Thu_Brain/',param1{i},xls)};
        
        brat_ibma(jobman, input_type);
        
    end
end
disp('-------------------------------DONE!!---------------------------')
exit;
