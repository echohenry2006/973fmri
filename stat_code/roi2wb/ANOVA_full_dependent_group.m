%clc;
%clear;
%spm('defaults','fmri');
%spm_jobman('initcfg');

site={'HLG','PKU6','WUHAN','XIAN','XX_GE','XX_SE','ZMD'}

group={'NC' 'SZ'}
%measure='046'
out_path=strcat('/DATA/234/sz_fmri/ALE_AH/WITH_GR/Thu_Brain/ANOVA_full/',measure(end-2:end))

if ~isdir(out_path)
    mkdir(out_path)
end




load('/DATA/234/sz_fmri/ALE_AH/WITH_GR/ROI_01_100_2012_trait_8mm_all/multi_center.mat');
ppath='/DATA/234/sz_fmri/ALE_AH/WITH_GR/ROI_01_100_2012_trait_8mm_all';



%-----------------------------------------------------------------------
% Job configuration created by cfg_util (rev $Rev: 4252 $)
%-----------------------------------------------------------------------
matlabbatch{1}.spm.stats.factorial_design.dir = mat2cell(out_path);
matlabbatch{1}.spm.stats.factorial_design.des.fd.fact(1).name = 'group';
matlabbatch{1}.spm.stats.factorial_design.des.fd.fact(1).levels = length(group);
matlabbatch{1}.spm.stats.factorial_design.des.fd.fact(1).dept = 1;
matlabbatch{1}.spm.stats.factorial_design.des.fd.fact(1).variance = 1;
matlabbatch{1}.spm.stats.factorial_design.des.fd.fact(1).gmsca = 0;
matlabbatch{1}.spm.stats.factorial_design.des.fd.fact(1).ancova = 0;
matlabbatch{1}.spm.stats.factorial_design.des.fd.fact(2).name = 'site';
matlabbatch{1}.spm.stats.factorial_design.des.fd.fact(2).levels = length(site);
matlabbatch{1}.spm.stats.factorial_design.des.fd.fact(2).dept = 0;
matlabbatch{1}.spm.stats.factorial_design.des.fd.fact(2).variance = 1;
matlabbatch{1}.spm.stats.factorial_design.des.fd.fact(2).gmsca = 0;
matlabbatch{1}.spm.stats.factorial_design.des.fd.fact(2).ancova = 0;

cov_sex=[];
cov_age=[];
for f1=1:length(group)
    for f2=1:length(site)
        switch f2
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
        fid=fopen(fullfile('/DATA/234/sz_fmri/ALE_AH/WITH_GR','sample/ALL_SZ_NC',strcat(site{f2},'_',group{f1},'.txt')));
        subj=textscan(fid,'%s');
        subj=subj{1};
        fclose(fid);
        
        switch measure
            case 'REHO'
                vol_file=strcat(data_path,'/s6_ReHo_26_nor_',subj,'.nii,1');
            case 'ALFF'
                vol_file=strcat(data_path,'/ALFF_z_',subj,'.nii,1');%
            otherwise
                vol_file=strcat(data_path,'/corr_Z_',subj,'.nii,1');
        end
        
        matlabbatch{1}.spm.stats.factorial_design.des.fd.icell((f2-1)*length(group)+f1).levels = [f1 f2];
        
        matlabbatch{1}.spm.stats.factorial_design.des.fd.icell((f2-1)*length(group)+f1).scans = vol_file;
        
        
        [subname,ind]=intersect(info.bh(:,1),subj);
        sex=info.sex(ind);
        age=info.age(ind);
        panss=info.panss(ind);
        g8=info.g8(ind);
        cov_sex=[cov_sex;sex];
        cov_age=[cov_age;age];
    end
    
    
    
    
end

matlabbatch{1}.spm.stats.factorial_design.cov(1).c = cov_sex;
matlabbatch{1}.spm.stats.factorial_design.cov(1).cname = 'sex';
matlabbatch{1}.spm.stats.factorial_design.cov(1).iCFI = 1;
matlabbatch{1}.spm.stats.factorial_design.cov(1).iCC = 1;
matlabbatch{1}.spm.stats.factorial_design.cov(2).c = cov_age;
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

spm_jobman('run',matlabbatch);
disp('------------------------------Done!!----------------------------------');
