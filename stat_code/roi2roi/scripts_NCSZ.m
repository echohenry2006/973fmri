clc;
clear all;

ppath='/DATA/234/sz_fmri/ALE_AH/WITH_GR/Rottschy_2012_main_ALL';

measure='corr_mat'

group={'NC','SZ'}
site={'HLG','PKU6','WUHAN','XIAN','XX_GE','XX_SE','ZMD'}

load('/DATA/234/sz_fmri/ALE_AH/WITH_GR/sample/multi_center_use.mat')

for i=1:length(site)
    
    
    
    switch i
        case 1
            info=multi_center_use.hlg;
            switch measure
                case 'REHO'
                    data_path='/DATA/233/sz_fmri/Results/hlg_reho27/ReHo_Normalized'
                case 'ALFF'
                    data_path='/DATA/233/sz_fmri/Results/hlg_alff/ALFF_Normalized'
                case {'005','006','007','008','009','010'}
                    data_path=strcat('/DATA/233/sz_fmri/HLG/corr_map/DFC_3mm/roi2wb/',measure)
                case {'046','092'}
                    data_path=strcat('/DATA/233/sz_fmri/HLG/corr_map/BA46/roi2wb/',measure)
                case {'corr_mat'}
                    data_path=strcat('/DATA/233/sz_fmri/HLG/corr_map/Rottschy_2012_main/roi2roi/',measure)
            end
        case 2
            info=multi_center_use.pku6;
            switch measure
                case 'REHO'
                    data_path='/DATA/231/sz_fmri/Results/pku6_reho27/ReHo_Normalized'
                case 'ALFF'
                    data_path='/DATA/231/sz_fmri/Results/pku6_alff/ALFF_Normalized'
                case {'005','006','007','008','009','010'}
                    data_path=strcat('/DATA/231/sz_fmri/PKU6/corr_map/DFC_3mm/roi2wb/',measure)
                case {'046','092'}
                    data_path=strcat('/DATA/231/sz_fmri/PKU6/corr_map/BA46/roi2wb/',measure)
                case {'corr_mat'}
                    data_path=strcat('/DATA/231/sz_fmri/PKU6/corr_map/Rottschy_2012_main/roi2roi/',measure)
            end
        case 3
            info=multi_center_use.wuhan;
            switch measure
                case 'REHO'
                    data_path='/DATA/234/sz_fmri/Results/wuhan_reho27/ReHo_Normalized'
                case 'ALFF'
                    data_path='/DATA/234/sz_fmri/Results/wuhan_alff/ALFF_Normalized'
                case {'005','006','007','008','009','010'}
                    data_path=strcat('/DATA/234/sz_fmri/wuhan_results/wuhan/corr_map/DFC_3mm/roi2wb/',measure)
                case {'046','092'}
                    data_path=strcat('/DATA/234/sz_fmri/wuhan_results/wuhan/corr_map/BA46/roi2wb/',measure)
                case {'corr_mat'}
                    data_path=strcat('/DATA/234/sz_fmri/wuhan_results/wuhan/corr_map/Rottschy_2012_main/roi2roi/',measure)
            end
        case 4
            info=multi_center_use.xian;
            switch measure
                case 'REHO'
                    data_path='/DATA/233/sz_fmri/Results/xian_reho27/ReHo_Normalized'
                case 'ALFF'
                    data_path='/DATA/233/sz_fmri/Results/xian_alff/ALFF_Normalized'
                case {'005','006','007','008','009','010'}
                    data_path=strcat('/DATA/233/sz_fmri/HLG/corr_map/DFC_3mm/roi2wb/',measure)
                case {'046','092'}
                    data_path=strcat('/DATA/233/sz_fmri/HLG/corr_map/BA46/roi2wb/',measure)
                case {'corr_mat'}
                    data_path=strcat('/DATA/233/sz_fmri/HLG/corr_map/Rottschy_2012_main/roi2roi/',measure)
            end
        case 5
            info=multi_center_use.xinxiang_ge;
            switch measure
                case 'REHO'
                    data_path='/DATA/232/sz_fmri/Results/xinxiang_ge_reho27/ReHo_Normalized'
                case 'ALFF'
                    data_path='/DATA/232/sz_fmri/Results/xinxiang_ge_alff/ALFF_Normalized'
                case {'005','006','007','008','009','010'}
                    data_path=strcat('/DATA/232/sz_fmri/ZMD/corr_map/DFC_3mm/roi2wb/',measure)
                case {'046','092'}
                    data_path=strcat('/DATA/232/sz_fmri/ZMD/corr_map/BA46/roi2wb/',measure)
                case {'corr_mat'}
                    data_path=strcat('/DATA/232/sz_fmri/ZMD/corr_map/Rottschy_2012_main/roi2roi/',measure)
            end
        case 6
            info=multi_center_use.xinxiang_se;
            switch measure
                case 'REHO'
                    data_path='/DATA/232/sz_fmri/Results/xinxiang_se_reho27/ReHo_Normalized'
                case 'ALFF'
                    data_path='/DATA/232/sz_fmri/Results/xinxiang_se_alff/ALFF_Normalized'
                case {'005','006','007','008','009','010'}
                    data_path=strcat('/DATA/232/sz_fmri/ZMD/corr_map/DFC_3mm/roi2wb/',measure)
                case {'046','092'}
                    data_path=strcat('/DATA/232/sz_fmri/ZMD/corr_map/BA46/roi2wb/',measure)
                case {'corr_mat'}
                    data_path=strcat('/DATA/232/sz_fmri/ZMD/corr_map/Rottschy_2012_main/roi2roi/',measure)
            end
        case 7
            info=multi_center_use.zmd;
            switch measure
                case 'REHO'
                    data_path='/DATA/232/sz_fmri/Results/zmd_reho27/ReHo_Normalized'
                case 'ALFF'
                    data_path='/DATA/232/sz_fmri/Results/zmd_alff/ALFF_Normalized'
                case {'005','006','007','008','009','010'}
                    data_path=strcat('/DATA/232/sz_fmri/ZMD/corr_map/DFC_3mm/roi2wb/',measure)
                case {'046','092'}
                    data_path=strcat('/DATA/232/sz_fmri/ZMD/corr_map/BA46/roi2wb/',measure)
                case {'corr_mat'}
                    data_path=strcat('/DATA/232/sz_fmri/ZMD/corr_map/Rottschy_2012_main/roi2roi/',measure)
            end
    end
    
    fid=fopen(fullfile('/DATA/234/sz_fmri/ALE_AH/WITH_GR','sample','ALL_match',strcat(site{i},'_',group{1},'.txt')));
    subj1=textscan(fid,'%s');
    subj1=subj1{1};
    fclose(fid);
    
    fid=fopen(fullfile('/DATA/234/sz_fmri/ALE_AH/WITH_GR','sample','ALL_match',strcat(site{i},'_',group{2},'.txt')));
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
        case 'corr_mat'
            AH_file=strcat(data_path,'/',subj1,'_corr.mat');
            NAH_file=strcat(data_path,'/',subj2,'_corr.mat');%
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
    
    
    
    

    
    AHz=[];
    for zz=1:length(AH_file)
        load(AH_file{zz});
        ss=squareform(1:nchoosek(size(corr_z,1),2));
        tr= tril(ss);
        AHz=[AHz corr_z(tr~=0)];
    end
    
    
    NAHz=[];
    for zz=1:length(NAH_file)
        load(NAH_file{zz});
        ss=squareform(1:nchoosek(size(corr_z,1),2));
        tr= tril(ss);
        NAHz=[NAHz corr_z(tr~=0)];
    end
    
    
    id=[ones(length(AHind),1); 2*ones(length(NAHind),1)];
    sex=[AHsex; NAHsex];
    age=[AHage; NAHage];
    g8=[AHg8; NAHg8];
    panss=[AHpanss;NAHpanss];
    	
    
 
    tmp = [AHz NAHz];
   
    
    
    
    tmp=[id sex age g8 panss tmp'];
    
    tmp=num2cell(tmp);
    
    names=[subj1; subj2];
	
    data=[names tmp];

    save(fullfile(ppath,site{i},'data.mat'),'data');
   % xlswrite(fullfile(ppath,site{i},'data.csv'),data,'fc','A1');
    
    
  
end

disp('------------------------------Done!!----------------------------------');
