clc;
clear all;

ppath='/DATA/234/sz_fmri/ALE_AH/WITH_GR/Rottschy_2012';


alpha =0.005

site={'HLG','PKU6','WUHAN','XIAN','XX_GE','XX_SE','ZMD'}

load('/DATA/234/sz_fmri/ALE_AH/WITH_GR/ROI_01_100_2012_trait_8mm_all/multi_center.mat')

for i=1:length(site)




fid=fopen(fullfile(ppath,site{i},'AH.txt'));
AH=textscan(fid,'%s');
AH=AH{1};
fclose(fid);

fid=fopen(fullfile(ppath,site{i},'NAH.txt'));
NAH=textscan(fid,'%s');
NAH=NAH{1};
fclose(fid);

fid=fopen(fullfile(ppath,site{i},'NC.txt'));
NC=textscan(fid,'%s');
NC=NC{1};
fclose(fid);

load(fullfile(ppath,site{i},'corr_z_tot.mat'));
load(fullfile(ppath,site{i},'brat_roi_roi.mat'));


[AHsub,AHind]=intersect(jobman.subj_infos.subjnames,AH);
[NAHsub,NAHind]=intersect(jobman.subj_infos.subjnames,NAH);
[NCsub,NCind]=intersect(jobman.subj_infos.subjnames,NC);

AHz=corr_z_tot(:,:,AHind);
NAHz=corr_z_tot(:,:,NAHind);
NCz=corr_z_tot(:,:,NCind);



AHmean=mean(AHz,3);
NAHmean=mean(NAHz,3);
NCmean=mean(NCz,3);


/DATA/231/sz_fmri/PKU6/corr_map/Rottschy_2012/roi2roi/corr_mat/HR_01_0001_corr.mat
   switch i
        case 1
            info=multi_center.hlg;
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
		    data_path=strcat('/DATA/233/sz_fmri/HLG/corr_map/Rottschy_2012/roi2roi/',measure)
            end
        case 2
            info=multi_center.pku6;
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
		    data_path=strcat('/DATA/231/sz_fmri/PKU6/corr_map/Rottschy_2012/roi2roi/',measure)
            end
        case 3
            info=multi_center.wuhan;
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
		    data_path=strcat('/DATA/234/sz_fmri/wuhan_results/wuhan/corr_map/Rottschy_2012/roi2roi/',measure)
            end
        case 4
            info=multi_center.xian;
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
		    data_path=strcat('/DATA/233/sz_fmri/HLG/corr_map/Rottschy_2012/roi2roi/',measure)
            end
        case 5
            info=multi_center.xinxiang_ge;
            switch measure
                case 'REHO'
                    data_path='/DATA/232/sz_fmri/Results/xinxiang_ge_reho27/ReHo_Normalized'
                case 'ALFF'
                    data_path='/DATA/232/sz_fmri/Results/xinxiang_ge_alff/ALFF_Normalized'
                case {'005','006','007','008','009','010'}
                    data_path=strcat('/DATA/232/sz_fmri/ZMD/corr_map/DFC_3mm/roi2wb/',measure)
                case {'046','092'}
                    data_path=strcat('/DATA/232/sz_fmri/ZMD/corr_map/BA46/roi2wb/',measure
		case {'corr_mat'}
		    data_path=strcat('/DATA/232/sz_fmri/ZMD/corr_map/Rottschy_2012/roi2roi/',measure)
        case 6
            info=multi_center.xinxiang_se;
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
		    data_path=strcat('/DATA/232/sz_fmri/ZMD/corr_map/Rottschy_2012/roi2roi/',measure)
            end
        case 7
            info=multi_center.zmd;
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
		    data_path=strcat('/DATA/232/sz_fmri/ZMD/corr_map/Rottschy_2012/roi2roi/',measure)
            end
    end

[AHsub,AHind]=intersect(info.bh(:,1),AH);
AHsex=info.sex(AHind);
AHage=info.age(AHind);
AHpanss=info.panss(AHind);
AHg8=info.g8(AHind);

[NAHsub,NAHind]=intersect(info.bh(:,1),NAH);
NAHsex=info.sex(NAHind);
NAHage=info.age(NAHind);
NAHpanss=info.panss(NAHind);
NAHg8=info.g8(NAHind);

[NCsub,NCind]=intersect(info.bh(:,1),NC);
NCsex=info.sex(NCind);
NCage=info.age(NCind);
NCpanss=info.panss(NCind);
NCg8=info.g8(NCind);


AHz2= reshape(AHz,[],size(AHz,3));
NAHz2= reshape(NAHz,[],size(NAHz,3));
NCz2= reshape(NCz,[],size(NCz,3));
SZz2= [AHz2 NAHz2];

ss=squareform(1:nchoosek(size(AHz,1),2));
tr= tril(ss);

tmp=[];
tmp=[AHz2,NAHz2,NCz2];
% tmp=[ones(size(AHz2',1),1),AHz2'];
% tmp=[tmp;[2*ones(size(NAHz2',1),1),NAHz2']];
% tmp=[tmp;[3*ones(size(NCz2',1),1),NCz2']];
tmp2=[];
for t=1:size(tmp,2)
    x=reshape(tmp(:,t),[size(AHz,1) size(AHz,2)]);
    tmp2=[tmp2 x(tr~=0)];
end

tmp2=[[AHpanss;NAHpanss;NCpanss] tmp2'];
tmp2=[[AHg8;NAHg8;NCg8] tmp2];
tmp2=[[AHage;NAHage;NCage] tmp2];
tmp2=[[AHsex;NAHsex;NCsex] tmp2];

tmp2=[[ones(size(AHz2',1),1);2*ones(size(NAHz2',1),1);3*ones(size(NCz2',1),1)] tmp2];

data=num2cell(tmp2);


xlswrite(fullfile(ppath,site{i},'data.csv'),data,'fc','A1');


data_reg=tmp2;

for t=6:size(data_reg,2)
[b bint r]= regress(data_reg(:,t),[ones(size(data_reg,1),1) data_reg(:,2:3)],0.05);
%[b bint r]= regress(data_reg(:,t),[data_reg(:,2:3)],0.05);
data_reg(:,t)=r;
end
xlswrite(fullfile(ppath,site{i},'data_reg.csv'),num2cell(data_reg),'fc','A1');

tmp=[[mean(data_reg(data_reg(:,1)==1,4:end),1);std(data_reg(data_reg(:,1)==1,4:end),0,1);std(data_reg(data_reg(:,1)==1,4:end),0,1)/sqrt(size(AHz2,2))];...
    [mean(data_reg(data_reg(:,1)==2,4:end),1);std(data_reg(data_reg(:,1)==2,4:end),0,1);std(data_reg(data_reg(:,1)==2,4:end),0,1)/sqrt(size(NAHz2,2))];...
    [mean(data_reg(data_reg(:,1)==3,4:end),1);std(data_reg(data_reg(:,1)==3,4:end),0,1);std(data_reg(data_reg(:,1)==3,4:end),0,1)/sqrt(size(NCz2,2))]];

tmp=tmp';
xlswrite(fullfile(ppath,site{i},'data_reg2.csv'),num2cell(tmp),'sum','A1');


tmp=[mean(AHz2,2),std(AHz2,0,2),std(AHz2,0,2)/sqrt(size(AHz2,2)),mean(NAHz2,2),std(NAHz2,0,2),std(NAHz2,0,2)/sqrt(size(NAHz2,2)),mean(NCz2,2),std(NCz2,0,2),std(NCz2,0,2)/sqrt(size(NCz2,2))];
tmp2=[];
for t=1:size(tmp,2)
    x=reshape(tmp(:,t),[size(AHz,1) size(AHz,2)]);
    tmp2=[tmp2 x(tr~=0)];
end
data=num2cell(tmp2);
xlswrite(fullfile(ppath,site{i},'data2.csv'),data,'sum','A1');
end
disp('------------------------------Done!!----------------------------------');
