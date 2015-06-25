clc;
clear;
spm('defaults','fmri');
spm_jobman('initcfg');

site={'HLG','PKU6','WUHAN','XIAN','XX_GE','XX_SE','ZMD'}
group={'NC' 'SZ'};
measure={'005','007'};


out_path_root=strcat('/DATA/234/sz_fmri/ALE_AH/WITH_GR/BA46_MFG/one_site_ROI_group/')




ppath='/DATA/234/sz_fmri/ALE_AH/WITH_GR/ROI_01_100_2012_trait_8mm_all';
load('/DATA/234/sz_fmri/ALE_AH/WITH_GR/ROI_01_100_2012_trait_8mm_all/multi_center.mat');






for i=1:length(site)
    clear matlabbatch;
    switch i
        case 1
            info=multi_center.hlg;
            
            data_path=strcat('/DATA/233/sz_fmri/HLG/corr_map/DFC_BA46/roi2wb/')
            
        case 2
            info=multi_center.pku6;
            data_path=strcat('/DATA/231/sz_fmri/PKU6/corr_map/DFC_BA46/roi2wb/')
            
        case 3
            info=multi_center.wuhan;
            
            data_path=strcat('/DATA/234/sz_fmri/wuhan_results/wuhan/corr_map/DFC_BA46/roi2wb/')
            
        case 4
            info=multi_center.xian;
            
            data_path=strcat('/DATA/233/sz_fmri/HLG/corr_map/DFC_BA46/roi2wb/')
            
        case 5
            info=multi_center.xinxiang_ge;
            
            data_path=strcat('/DATA/232/sz_fmri/ZMD/corr_map/DFC_BA46/roi2wb/')
            
        case 6
            info=multi_center.xinxiang_se;
            
            data_path=strcat('/DATA/232/sz_fmri/ZMD/corr_map/DFC_BA46/roi2wb/')
            
        case 7
            info=multi_center.zmd;
            
            data_path=strcat('/DATA/232/sz_fmri/ZMD/corr_map/DFC_BA46/roi2wb/')
    end
    
    
    
    fid=fopen(fullfile('/DATA/234/sz_fmri/ALE_AH/WITH_GR','FES_match',strcat(site{i},'_',group{1},'.txt')));
    subj1=textscan(fid,'%s');
    subj1=subj1{1};
    fclose(fid);
    
    fid=fopen(fullfile('/DATA/234/sz_fmri/ALE_AH/WITH_GR','FES_match',strcat(site{i},'_',group{2},'.txt')));
    subj2=textscan(fid,'%s');
    subj2=subj2{1};
    fclose(fid);
    
    
    
    [NCsub,NCind]=intersect(info.bh(:,1),subj1);
    NCsex=info.sex(NCind);
    NCage=info.age(NCind);
    NCpanss=info.panss(NCind);
    NCg8=info.g8(NCind);
    
    [SZsub,SZind]=intersect(info.bh(:,1),subj2);
    SZsex=info.sex(SZind);
    SZage=info.age(SZind);
    SZpanss=info.panss(SZind);
    SZg8=info.g8(SZind);
    
    
    out_path=fullfile(out_path_root,site{i})
    
    if ~isdir(out_path)
        mkdir(out_path)
    end
    
    
    
    
    %-----------------------------------------------------------------------
    % Job configuration created by cfg_util (rev $Rev: 4252 $)
    %-----------------------------------------------------------------------
    matlabbatch{1}.spm.stats.factorial_design.dir = {out_path};
    matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(1).name = 'subject';
    matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(1).dept = 0;
    matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(1).variance = 0;
    matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(1).gmsca = 0;
    matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(1).ancova = 0;
    matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(2).name = 'group';
    matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(2).dept = 0;
    matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(2).variance = 1;
    matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(2).gmsca = 0;
    matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(2).ancova = 0;
    matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(3).name = 'ROI';
    matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(3).dept = 1;
    matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(3).variance = 1;
    matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(3).gmsca = 0;
    matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(3).ancova = 0;
    
    for sub =1:length(NCsub)
        
        
        NC_file=strcat(data_path,measure','/corr_Z_',NCsub{sub},'.nii,1');
        %  NC_file=cell2mat(NC_file);
        
        
        
        
        matlabbatch{1}.spm.stats.factorial_design.des.fblock.fsuball.fsubject(sub).scans = NC_file;
        matlabbatch{1}.spm.stats.factorial_design.des.fblock.fsuball.fsubject(sub).conds = [1 1
            1 2];
    end
    
    
    for sub =1:length(SZsub)
        
        
        SZ_file=strcat(data_path,measure','/corr_Z_',SZsub{sub},'.nii,1');
        % SZ_file=cell2mat(SZ_file);
        
        
        
        matlabbatch{1}.spm.stats.factorial_design.des.fblock.fsuball.fsubject(sub+length(NCsub)).scans = SZ_file;
        matlabbatch{1}.spm.stats.factorial_design.des.fblock.fsuball.fsubject(sub+length(NCsub)).conds = [2 1
            2 2];
    end
    
    matlabbatch{1}.spm.stats.factorial_design.des.fblock.maininters{1}.fmain.fnum = 2;
    matlabbatch{1}.spm.stats.factorial_design.des.fblock.maininters{2}.fmain.fnum = 3;
    matlabbatch{1}.spm.stats.factorial_design.des.fblock.maininters{3}.inter.fnums = [2
        3];
    sex=zeros(2*(length(NCsex)+length(SZsex)),1);
    sex(1:2:end)=[NCsex;SZsex];
    sex(2:2:end)=[NCsex;SZsex];
    
    age=zeros(2*(length(NCage)+length(SZage)),1);
    age(1:2:end)=[NCage;SZage];
    age(2:2:end)=[NCage;SZage];
    
    
    matlabbatch{1}.spm.stats.factorial_design.cov(1).c = sex;
    matlabbatch{1}.spm.stats.factorial_design.cov(1).cname = 'sex';
    matlabbatch{1}.spm.stats.factorial_design.cov(1).iCFI = 1;
    matlabbatch{1}.spm.stats.factorial_design.cov(1).iCC = 1;
    matlabbatch{1}.spm.stats.factorial_design.cov(2).c = age;
    matlabbatch{1}.spm.stats.factorial_design.cov(2).cname = 'age';
    matlabbatch{1}.spm.stats.factorial_design.cov(2).iCFI = 1;
    matlabbatch{1}.spm.stats.factorial_design.cov(2).iCC = 1;
    matlabbatch{1}.spm.stats.factorial_design.masking.tm.tm_none = 1;
    matlabbatch{1}.spm.stats.factorial_design.masking.im = 1;
    matlabbatch{1}.spm.stats.factorial_design.masking.em = {'/DATA/238/yyang/workspace/973_FMRI/ROIS/DFC/grey_40_and_AAL_EPI.nii,1'};
    matlabbatch{1}.spm.stats.factorial_design.globalc.g_omit = 1;
    matlabbatch{1}.spm.stats.factorial_design.globalm.gmsca.gmsca_no = 1;
    matlabbatch{1}.spm.stats.factorial_design.globalm.glonorm = 1;
    
    
    matlabbatch{2}.spm.stats.fmri_est.spmmat = {fullfile(out_path,'SPM.mat')};
    matlabbatch{2}.spm.stats.fmri_est.method.Classical = 1;
    
    MEg=[1 -1];
    MEc=[1 -1];
    nc=length(measure);
    ng=length(group);
    n1=length(NCsub);
    n2=length(SZsub);
    
    matlabbatch{3}.spm.stats.con.spmmat = {fullfile(out_path,'SPM.mat')};
    matlabbatch{3}.spm.stats.con.consess{1}.fcon.name = 'group';
    matlabbatch{3}.spm.stats.con.consess{1}.fcon.convec = {[MEg zeros(1,nc) ones(1,nc)/nc -ones(1,nc)/nc]};
    matlabbatch{3}.spm.stats.con.consess{1}.fcon.sessrep = 'none';
    matlabbatch{3}.spm.stats.con.consess{2}.fcon.name = 'roi';
    matlabbatch{3}.spm.stats.con.consess{2}.fcon.convec = {[zeros(1,ng) MEc MEc*(n1/(n1+n2)) MEc*(n2/(n1+n2))]};
    matlabbatch{3}.spm.stats.con.consess{2}.fcon.sessrep = 'none';
    matlabbatch{3}.spm.stats.con.consess{3}.fcon.name = 'group_roi';
    matlabbatch{3}.spm.stats.con.consess{3}.fcon.convec = {[zeros(1,ng) zeros(1,nc) MEc -MEc]};
    matlabbatch{3}.spm.stats.con.consess{3}.fcon.sessrep = 'none';
    matlabbatch{3}.spm.stats.con.consess{4}.tcon.name = strcat(group{1},'-',group{2});
    matlabbatch{3}.spm.stats.con.consess{4}.tcon.convec = [MEg zeros(1,nc) ones(1,nc)/nc -ones(1,nc)/nc];
    matlabbatch{3}.spm.stats.con.consess{4}.tcon.sessrep = 'none';
    matlabbatch{3}.spm.stats.con.consess{5}.tcon.name = strcat(group{2},'-',group{1});
    matlabbatch{3}.spm.stats.con.consess{5}.tcon.convec = -[MEg zeros(1,nc) ones(1,nc)/nc -ones(1,nc)/nc];
    matlabbatch{3}.spm.stats.con.consess{5}.tcon.sessrep = 'none';
    matlabbatch{3}.spm.stats.con.consess{6}.tcon.name = strcat(measure{1},'-',measure{2});
    matlabbatch{3}.spm.stats.con.consess{6}.tcon.convec = [zeros(1,ng) MEc MEc*(n1/(n1+n2)) MEc*(n2/(n1+n2))];
    matlabbatch{3}.spm.stats.con.consess{6}.tcon.sessrep = 'none';
    matlabbatch{3}.spm.stats.con.consess{7}.tcon.name = strcat(measure{2},'-',measure{1});
    matlabbatch{3}.spm.stats.con.consess{7}.tcon.convec = [zeros(1,ng) MEc MEc*(n1/(n1+n2)) MEc*(n2/(n1+n2))];
    matlabbatch{3}.spm.stats.con.consess{7}.tcon.sessrep = 'none';
    matlabbatch{3}.spm.stats.con.delete = 0;
    
    spm_jobman('run',matlabbatch);
end
disp('------------------------------Done!!----------------------------------');
