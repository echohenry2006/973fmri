clc;
clear all;

ppath='/DATA/234/sz_fmri/ALE_AH/WITH_GR/ROI_01_100_2012_trait_ALE';


alpha =0.005

site={'PKU6','XIAN','XX_GE','XX_SE','ZMD','WUHAN'}

load('/DATA/234/sz_fmri/ALE_AH/WITH_GR/ROI_01_100_2012_trait_8mm_all/multi_center.mat')

for i=1:length(site)

fid=fopen(strcat('/DATA/234/sz_fmri/ALE_AH/WITH_GR/sample/AVH2_match/',site{i},'_AH.txt'));
AH=textscan(fid,'%s');
AH=AH{1};
fclose(fid);

fid=fopen(strcat('/DATA/234/sz_fmri/ALE_AH/WITH_GR/sample/AVH2_match/',site{i},'_NAH.txt'));
NAH=textscan(fid,'%s');
NAH=NAH{1};
fclose(fid);

fid=fopen(strcat('/DATA/234/sz_fmri/ALE_AH/WITH_GR/sample/AVH2_match/',site{i},'_NC.txt'));
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

switch i 
case 1
info=multi_center.hlg;
case 2
info=multi_center.pku6;
case 3
info=multi_center.wuhan;
case 4
info=multi_center.xian;
case 5
info=multi_center.xinxiang_ge;
case 6
info=multi_center.xinxiang_se;
case 7
info=multi_center.zmd;
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

colormap('Jet');

% figure(1)
% imagesc(AHmean);caxis([-0.4,1.4]);figure(gcf);colorbar();
% saveas(gcf,fullfile(ppath,site{i},'AHmean.png'),'png');
% close(figure(1));
% 
% figure(2)
% imagesc(NAHmean);caxis([-0.4,1.4]);figure(gcf);colorbar();
% saveas(gcf,fullfile(ppath,site{i},'NAHmean.png'),'png');
% close(figure(2));
% 
% figure(3)
% imagesc(NCmean);caxis([-0.4,1.4]);figure(gcf);colorbar();
% saveas(gcf,fullfile(ppath,site{i},'NCmean.png'),'png');
% close(figure(3));
% 
% 
% AH_sub_NAH=AHmean-NAHmean;
% AH_sub_NC=AHmean-NCmean;
% NAH_sub_NC=NAHmean-NCmean;
% 
% 
% figure(4)
% imagesc(AH_sub_NAH);caxis([-0.4,1.4]);figure(gcf);colorbar();
% saveas(gcf,fullfile(ppath,site{i},'AH_sub_NAH.png'),'png');
% close(figure(4));
% 
% figure(5)
% imagesc(AH_sub_NC);caxis([-0.4,1.4]);figure(gcf);colorbar();
% saveas(gcf,fullfile(ppath,site{i},'AH_sub_NC.png'),'png');
% close(figure(5));
% 
% figure(6)
% imagesc(NAH_sub_NC);caxis([-0.4,1.4]);figure(gcf);colorbar();
% saveas(gcf,fullfile(ppath,site{i},'NAH_sub_NC.png'),'png');
% close(figure(6));

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
%[b bint r]= regress(data_reg(:,t),[ones(size(data_reg,1),1) data_reg(:,2:3)],0.05);
[b bint r]= regress(data_reg(:,t),[data_reg(:,2:3)],0.05);
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

% STAT(i).ANO=zeros(size(AHz2,1),1);
% for j=1:size(AHz2,1)
% STAT(i).ANO(j)=anova1([AHz2(j,:)' NAHz2(j,:)' NCz2(j,:)'],[],'off');
% end

% [STAT(i).H_ah_sub_nah_l,STAT(i).P_ah_sub_nah_l,CI,STAT(i).stat_ah_sub_nah_l] = ttest2(AHz2',NAHz2',alpha,'left');
% figure(5);
% tmp=reshape(STAT(i).H_ah_sub_nah_l,[size(AHz,1),size(AHz,1)]);
% imagesc(tmp);figure(gcf);colorbar();
% saveas(gcf,fullfile(ppath,site{i},'H_AH_sub_NAH_L.png'),'png');
% close(figure(5));
% 
% [STAT(i).H_ah_sub_nah_r,STAT(i).P_ah_sub_nah_r,CI,STAT(i).stat_ah_sub_nah_r] = ttest2(AHz2',NAHz2',alpha,'right');
% figure(5);
% tmp=reshape(STAT(i).H_ah_sub_nah_r,[size(AHz,1),size(AHz,1)]);
% imagesc(tmp);figure(gcf);colorbar();
% saveas(gcf,fullfile(ppath,site{i},'H_AH_sub_NAH_R.png'),'png');
% close(figure(5));
% 
% [STAT(i).H_ah_sub_nc_l,STAT(i).P_ah_sub_nc_l,CI,STAT(i).stat_ah_sub_nc_l] = ttest2(AHz2',NCz2',alpha,'left');
% figure(5);
% tmp=reshape(STAT(i).H_ah_sub_nc_l,[size(AHz,1),size(AHz,1)]);
% imagesc(tmp);figure(gcf);colorbar();
% saveas(gcf,fullfile(ppath,site{i},'H_AH_sub_NC_L.png'),'png');
% close(figure(5));
% 
% [STAT(i).H_ah_sub_nc_r,STAT(i).P_ah_sub_nc_r,CI,STAT(i).stat_ah_sub_nc_r] = ttest2(AHz2',NCz2',alpha,'right');
% figure(5);
% tmp=reshape(STAT(i).H_ah_sub_nc_r,[size(AHz,1),size(AHz,1)]);
% imagesc(tmp);figure(gcf);colorbar();
% saveas(gcf,fullfile(ppath,site{i},'H_AH_sub_NC_R.png'),'png');
% close(figure(5));
% 
% [STAT(i).H_nah_sub_nc_l,STAT(i).P_nah_sub_nc_l,CI,STAT(i).stat_nah_sub_nc_l] = ttest2(NAHz2',NCz2',alpha,'left');
% figure(5);
% tmp=reshape(STAT(i).H_nah_sub_nc_l,[size(AHz,1),size(AHz,1)]);
% imagesc(tmp);figure(gcf);colorbar();
% saveas(gcf,fullfile(ppath,site{i},'H_NAH_sub_NC_L.png'),'png');
% close(figure(5));
% 
% [STAT(i).H_nah_sub_nc_r,STAT(i).P_nah_sub_nc_r,CI,STAT(i).stat_nah_sub_nc_r] = ttest2(NAHz2',NCz2',alpha,'right');
% figure(5);
% tmp=reshape(STAT(i).H_nah_sub_nc_r,[size(AHz,1),size(AHz,1)]);
% imagesc(tmp);figure(gcf);colorbar();
% saveas(gcf,fullfile(ppath,site{i},'H_NAH_sub_NC_R.png'),'png');
% close(figure(5));
% 
% [STAT(i).H_sz_sub_nc_l,STAT(i).P_sz_sub_nc_l,CI,STAT(i).stat_sz_sub_nc_l] = ttest2(SZz2',NCz2',alpha,'left');
% figure(5);
% tmp=reshape(STAT(i).H_sz_sub_nc_l,[size(AHz,1),size(AHz,1)]);
% imagesc(tmp);figure(gcf);colorbar();
% saveas(gcf,fullfile(ppath,site{i},'H_SZ_sub_NC_L.png'),'png');
% close(figure(5));
% 
% [STAT(i).H_sz_sub_nc_r,STAT(i).P_sz_sub_nc_r,CI,STAT(i).stat_sz_sub_nc_r] = ttest2(SZz2',NCz2',alpha,'right');
% figure(5);
% tmp=reshape(STAT(i).H_sz_sub_nc_r,[size(AHz,1),size(AHz,1)]);
% imagesc(tmp);figure(gcf);colorbar();
% saveas(gcf,fullfile(ppath,site{i},'H_SZ_sub_NC_R.png'),'png');
% close(figure(5));


%%
% H_ah_sub_nah_l(isnan(H_ah_sub_nah_l))=0;
% H_ah_sub_nah_r(isnan(H_ah_sub_nah_r))=0;
% 
% H_ah_sub_nc_l(isnan(H_ah_sub_nc_l))=0;
% H_ah_sub_nc_r(isnan(H_ah_sub_nc_r))=0;
% 
% H_nah_sub_nc_l(isnan(H_nah_sub_nc_l))=0;
% H_nah_sub_nc_r(isnan(H_nah_sub_nc_r))=0;


end


save('STAT.mat','STAT')
