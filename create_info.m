site ={'PKU6','HLG','XIAN','WUHAN','XX_GE','XX_SE','ZMD'};
site_str ={'pku6','hlg','xian','wuhan','xinxiang_ge','xinxiang_se','zmd'};
[num,txt,raw]=xlsread('multi_sites_use_eq_1_panss_scores_CRF.xlsx');

for i=1:length(site)
    ind=strcmp(raw(:,7),site{i});
    str=strcat('multi_center_use.',site_str{i},'.bh=raw(ind,1)');eval(str);
    str=strcat('multi_center_use.',site_str{i},'.sex=cell2mat(raw(ind,2))');eval(str);
    str=strcat('multi_center_use.',site_str{i},'.age=cell2mat(raw(ind,3))');eval(str);
    str=strcat('multi_center_use.',site_str{i},'.panss=cell2mat(raw(ind,4))');eval(str);
    str=strcat('multi_center_use.',site_str{i},'.g8=cell2mat(raw(ind,5))');eval(str);
end
save('multi_center_use.mat','multi_center_use')