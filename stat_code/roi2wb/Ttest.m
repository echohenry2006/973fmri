%clc;
%clear;
%spm('defaults','fmri');
%spm_jobman('initcfg');

site={'HLG','PKU6','WUHAN','XIAN','XX_GE','XX_SE','ZMD'}
group={'NC' 'SZ'}
%measure='046'
out_path_root=strcat('/DATA/234/sz_fmri/ALE_AH/WITH_GR/Thu_Brain/Ttest/',measure(end-2:end))




ppath='/DATA/234/sz_fmri/ALE_AH/WITH_GR/ROI_01_100_2012_trait_8mm_all';
load('/DATA/234/sz_fmri/ALE_AH/WITH_GR/ROI_01_100_2012_trait_8mm_all/multi_center.mat');


spm('defaults','fmri');
spm_jobman('initcfg');



for i=1:length(site)
    switch i
        case 1
            info=multi_center.hlg;
            switch measure
                case 'REHO'
                    data_path='/DATA/233/sz_fmri/Results/hlg_reho27/ReHo_Normalized'
                case 'ALFF'
                    data_path='/DATA/233/sz_fmri/Results/hlg_alff/ALFF_Normalized'
                case {'005','006','007','008','009','010'}
                    data_path=strcat('/DATA/233/sz_fmri/HLG/corr_map/DFC_BA46/roi2wb/',measure(end-2:end))
                case {'046','092'}
                    data_path=strcat('/DATA/233/sz_fmri/HLG/corr_map/BA46_MFG/roi2wb/',measure(end-2:end))
                case {'001','002'}
                    data_path=strcat('/DATA/233/sz_fmri/HLG/corr_map/BA46_Orb_R/roi2wb/',measure(end-2:end))
                case {'Thu_Brain_001','Thu_Brain_002','Thu_Brain_003','Thu_Brain_004','Thu_Brain_005','Thu_Brain_006'}
                    data_path=strcat('/DATA/233/sz_fmri/HLG/corr_map/Thu_Brain/roi2wb/',measure(end-2:end))
            end
        case 2
            info=multi_center.pku6;
            switch measure
                case 'REHO'
                    data_path='/DATA/231/sz_fmri/Results/pku6_reho27/ReHo_Normalized'
                case 'ALFF'
                    data_path='/DATA/231/sz_fmri/Results/pku6_alff/ALFF_Normalized'
                case {'005','006','007','008','009','010'}
                    data_path=strcat('/DATA/231/sz_fmri/PKU6/corr_map/DFC_BA46/roi2wb/',measure(end-2:end))
                case {'046','092'}
                    data_path=strcat('/DATA/231/sz_fmri/PKU6/corr_map/BA46_MFG/roi2wb/',measure(end-2:end))
                case {'001','002'}
                    data_path=strcat('/DATA/231/sz_fmri/PKU6/corr_map/BA46_Orb_R/roi2wb/',measure(end-2:end))
               case {'Thu_Brain_001','Thu_Brain_002','Thu_Brain_003','Thu_Brain_004','Thu_Brain_005','Thu_Brain_006'}
                    data_path=strcat('/DATA/231/sz_fmri/PKU6/corr_map/Thu_Brain/roi2wb/',measure(end-2:end))
            end
        case 3
            info=multi_center.wuhan;
            switch measure
                case 'REHO'
                    data_path='/DATA/234/sz_fmri/Results/wuhan_reho27/ReHo_Normalized'
                case 'ALFF'
                    data_path='/DATA/234/sz_fmri/Results/wuhan_alff/ALFF_Normalized'
                case {'005','006','007','008','009','010'}
                    data_path=strcat('/DATA/234/sz_fmri/wuhan_results/wuhan/corr_map/DFC_BA46/roi2wb/',measure(end-2:end))
                case {'046','092'}
                    data_path=strcat('/DATA/234/sz_fmri/wuhan_results/wuhan/corr_map/BA46_MFG/roi2wb/',measure(end-2:end))
                case {'001','002'}
                    data_path=strcat('/DATA/234/sz_fmri/wuhan_results/wuhan/corr_map/BA46_Orb_R/roi2wb/',measure(end-2:end))
               case {'Thu_Brain_001','Thu_Brain_002','Thu_Brain_003','Thu_Brain_004','Thu_Brain_005','Thu_Brain_006'}
                    data_path=strcat('/DATA/234/sz_fmri/wuhan_results/wuhan/corr_map/Thu_Brain/roi2wb/',measure(end-2:end))
            end
        case 4
            info=multi_center.xian;
            switch measure
                case 'REHO'
                    data_path='/DATA/233/sz_fmri/Results/xian_reho27/ReHo_Normalized'
                case 'ALFF'
                    data_path='/DATA/233/sz_fmri/Results/xian_alff/ALFF_Normalized'
                case {'005','006','007','008','009','010'}
                    data_path=strcat('/DATA/233/sz_fmri/HLG/corr_map/DFC_BA46/roi2wb/',measure(end-2:end))
                case {'046','092'}
                    data_path=strcat('/DATA/233/sz_fmri/HLG/corr_map/BA46_MFG/roi2wb/',measure(end-2:end))
                case {'001','002'}
                    data_path=strcat('/DATA/233/sz_fmri/HLG/corr_map/BA46_Orb_R/roi2wb/',measure(end-2:end))
               case {'Thu_Brain_001','Thu_Brain_002','Thu_Brain_003','Thu_Brain_004','Thu_Brain_005','Thu_Brain_006'}
                    data_path=strcat('/DATA/233/sz_fmri/HLG/corr_map/Thu_Brain/roi2wb/',measure(end-2:end))
            end
        case 5
            info=multi_center.xinxiang_ge;
            switch measure
                case 'REHO'
                    data_path='/DATA/232/sz_fmri/Results/xinxiang_ge_reho27/ReHo_Normalized'
                case 'ALFF'
                    data_path='/DATA/232/sz_fmri/Results/xinxiang_ge_alff/ALFF_Normalized'
                case {'005','006','007','008','009','010'}
                    data_path=strcat('/DATA/232/sz_fmri/ZMD/corr_map/DFC_BA46/roi2wb/',measure(end-2:end))
                case {'046','092'}
                    data_path=strcat('/DATA/232/sz_fmri/ZMD/corr_map/BA46_MFG/roi2wb/',measure(end-2:end))
                case {'001','002'}
                    data_path=strcat('/DATA/232/sz_fmri/ZMD/corr_map/BA46_Orb_R/roi2wb/',measure(end-2:end))
               case {'Thu_Brain_001','Thu_Brain_002','Thu_Brain_003','Thu_Brain_004','Thu_Brain_005','Thu_Brain_006'}
                    data_path=strcat('/DATA/232/sz_fmri/ZMD/corr_map/Thu_Brain/roi2wb/',measure(end-2:end))
            end
        case 6
            info=multi_center.xinxiang_se;
            switch measure
                case 'REHO'
                    data_path='/DATA/232/sz_fmri/Results/xinxiang_se_reho27/ReHo_Normalized'
                case 'ALFF'
                    data_path='/DATA/232/sz_fmri/Results/xinxiang_se_alff/ALFF_Normalized'
                case {'005','006','007','008','009','010'}
                    data_path=strcat('/DATA/232/sz_fmri/ZMD/corr_map/DFC_BA46/roi2wb/',measure(end-2:end))
                case {'046','092'}
                    data_path=strcat('/DATA/232/sz_fmri/ZMD/corr_map/BA46_MFG/roi2wb/',measure(end-2:end))
                case {'001','002'}
                    data_path=strcat('/DATA/232/sz_fmri/ZMD/corr_map/BA46_Orb_R/roi2wb/',measure(end-2:end))
               case {'Thu_Brain_001','Thu_Brain_002','Thu_Brain_003','Thu_Brain_004','Thu_Brain_005','Thu_Brain_006'}
                    data_path=strcat('/DATA/232/sz_fmri/ZMD/corr_map/Thu_Brain/roi2wb/',measure(end-2:end))
            end
        case 7
            info=multi_center.zmd;
            switch measure
                case 'REHO'
                    data_path='/DATA/232/sz_fmri/Results/zmd_reho27/ReHo_Normalized'
                case 'ALFF'
                    data_path='/DATA/232/sz_fmri/Results/zmd_alff/ALFF_Normalized'
                case {'005','006','007','008','009','010'}
                    data_path=strcat('/DATA/232/sz_fmri/ZMD/corr_map/DFC_BA46/roi2wb/',measure(end-2:end))
                case {'046','092'}
                    data_path=strcat('/DATA/232/sz_fmri/ZMD/corr_map/BA46_MFG/roi2wb/',measure(end-2:end))
                case {'001','002'}
                    data_path=strcat('/DATA/232/sz_fmri/ZMD/corr_map/BA46_Orb_R/roi2wb/',measure(end-2:end))
               case {'Thu_Brain_001','Thu_Brain_002','Thu_Brain_003','Thu_Brain_004','Thu_Brain_005','Thu_Brain_006'}
                    data_path=strcat('/DATA/232/sz_fmri/ZMD/corr_map/Thu_Brain/roi2wb/',measure(end-2:end))
            end
    end
    
    
    fid=fopen(fullfile('/DATA/234/sz_fmri/ALE_AH/WITH_GR','sample/ALL_SZ_NC',strcat(site{i},'_',group{1},'.txt')));
    subj1=textscan(fid,'%s');
    subj1=subj1{1};
    fclose(fid);
    
    fid=fopen(fullfile('/DATA/234/sz_fmri/ALE_AH/WITH_GR','sample/ALL_SZ_NC',strcat(site{i},'_',group{2},'.txt')));
    subj2=textscan(fid,'%s');
    subj2=subj2{1};
    fclose(fid);
    
    switch measure
        case 'REHO'
            AH_file=strcat(data_path,'/s6_ReHo_26_nor_',subj1,'.nii,1');
            NAH_file=strcat(data_path,'/s6_ReHo_26_nor_',subj2,'.nii,1');
            
        case 'ALFF'
            AH_file=strcat(data_path,'/ALFF_z_',subj1,'.nii,1');
            NAH_file=strcat(data_path,'/ALFF_z_',subj2,'.nii,1');%
        otherwise
            AH_file=strcat(data_path,'/corr_Z_',subj1,'.nii,1');
            NAH_file=strcat(data_path,'/corr_Z_',subj2,'.nii,1');
    end
    
    [AHsub,AHind]=intersect(info.bh(:,1),subj1);
    AHsex=info.sex(AHind);
    AHage=info.age(AHind);
    AHpanss=info.panss(AHind);
    AHg8=info.g8(AHind);
    
    [NAHsub,NAHind]=intersect(info.bh(:,1),subj2);
    NAHsex=info.sex(NAHind);
    NAHage=info.age(NAHind);
    NAHpanss=info.panss(NAHind);
    NAHg8=info.g8(NAHind);
    
    
    out_path=fullfile(out_path_root,site{i})
    
    if ~isdir(out_path)
        mkdir(out_path)
    end
    
    %-----------------------------------------------------------------------
    % Job configuration created by cfg_util (rev $Rev: 4252 $)
    %-----------------------------------------------------------------------
    matlabbatch{1}.spm.stats.factorial_design.dir = {out_path};
    matlabbatch{1}.spm.stats.factorial_design.des.t2.scans1 = AH_file;
    
    matlabbatch{1}.spm.stats.factorial_design.des.t2.scans2 = NAH_file;
    matlabbatch{1}.spm.stats.factorial_design.des.t2.dept = 0;
    matlabbatch{1}.spm.stats.factorial_design.des.t2.variance = 1;
    matlabbatch{1}.spm.stats.factorial_design.des.t2.gmsca = 0;
    matlabbatch{1}.spm.stats.factorial_design.des.t2.ancova = 0;
    matlabbatch{1}.spm.stats.factorial_design.cov(1).c = [AHsex ;NAHsex];
    matlabbatch{1}.spm.stats.factorial_design.cov(1).cname = 'sex';
    matlabbatch{1}.spm.stats.factorial_design.cov(1).iCFI = 1;
    matlabbatch{1}.spm.stats.factorial_design.cov(1).iCC = 1;
    matlabbatch{1}.spm.stats.factorial_design.cov(2).c = [AHage ; NAHage];
    matlabbatch{1}.spm.stats.factorial_design.cov(2).cname = 'age';
    matlabbatch{1}.spm.stats.factorial_design.cov(2).iCFI = 1;
    matlabbatch{1}.spm.stats.factorial_design.cov(2).iCC = 1;
    matlabbatch{1}.spm.stats.factorial_design.masking.tm.tm_none = 1;
    matlabbatch{1}.spm.stats.factorial_design.masking.im = 1;
    %matlabbatch{1}.spm.stats.factorial_design.masking.em = {'/DATA/231/kbxu/Brat/template/AAL_mask_2mm.nii,1'};
    matlabbatch{1}.spm.stats.factorial_design.masking.em = {'/DATA/238/yyang/workspace/973_FMRI/ROIS/Thulamus/rThalamus_HO_AAL_3mm.nii,1'};
    matlabbatch{1}.spm.stats.factorial_design.globalc.g_omit = 1;
    matlabbatch{1}.spm.stats.factorial_design.globalm.gmsca.gmsca_no = 1;
    matlabbatch{1}.spm.stats.factorial_design.globalm.glonorm = 1;
    
    
    %-----------------------------------------------------------------------
    % Job configuration created by cfg_util (rev $Rev: 4252 $)
    %-----------------------------------------------------------------------
    matlabbatch{2}.spm.stats.fmri_est.spmmat = {fullfile(out_path,'/SPM.mat')};
    matlabbatch{2}.spm.stats.fmri_est.method.Classical = 1;
    matlabbatch{3}.spm.stats.con.spmmat = {fullfile(out_path,'SPM.mat')};
    matlabbatch{3}.spm.stats.con.consess{1}.tcon.name = strcat(group{1},'-',group{2});
    matlabbatch{3}.spm.stats.con.consess{1}.tcon.convec = [1 -1];
    matlabbatch{3}.spm.stats.con.consess{1}.tcon.sessrep = 'none';
    matlabbatch{3}.spm.stats.con.consess{2}.tcon.name = strcat(group{2},'-',group{1});
    matlabbatch{3}.spm.stats.con.consess{2}.tcon.convec = [-1 1];
    matlabbatch{3}.spm.stats.con.consess{2}.tcon.sessrep = 'none';
    matlabbatch{3}.spm.stats.con.delete = 0;
    
    
    spm_jobman('run',matlabbatch);
    
end
disp('------------------------------Done!!----------------------------------');
