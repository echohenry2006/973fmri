
param1={'one_sample_Ttest_NC','one_sample_Ttest_SZ','Ttest'};
param2={'001','002','003','004','005','006'};

for i=1:1;%length(param1)
    for j=1:1%length(param2)
%         clear;
%         clc;
        
        load jobman.mat
        input_type = {'voxel'};
        
        jobman.out_dir= {strcat('/DATA/234/sz_fmri/ALE_AH/WITH_GR/Thu_Brain/',param1{i},'/',param2{j},'/meta/')};
        
        jobman.mask= {'/DATA/234/sz_fmri/ALE_AH/WITH_GR/Thu_Brain/rThalamus_HO_AAL_3mm.nii'};
        
        jobman.input_nifti.dirs = {strcat('/DATA/234/sz_fmri/ALE_AH/WITH_GR/Thu_Brain/',param1{i},'/',param2{j},'/meta/')};
        
        if( exist( strcat( '/DATA/234/sz_fmri/ALE_AH/WITH_GR/Thu_Brain/',param1{i},'/oo_info_ttest.xlsx'),'file') )
            
            jobman.num_subjs_tbl= {strcat('/DATA/234/sz_fmri/ALE_AH/WITH_GR/Thu_Brain/',param1{i},'/oo_info_ttest.xlsx')};
        else
            
            jobman.num_subjs_tbl= {strcat('/DATA/234/sz_fmri/ALE_AH/WITH_GR/Thu_Brain/',param1{i},'/oo_info_ttest2.xlsx')};
        end
        
        
        
        brat_ibma(jobman, input_type);
        
    end
end
