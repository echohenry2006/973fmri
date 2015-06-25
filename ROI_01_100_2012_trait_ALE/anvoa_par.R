rm(list = ls())

library("car", lib.loc="C:/Users/thinkingfly/Documents/R/win-library/3.1")
library("metafor", lib.loc="C:/Users/thinkingfly/Documents/R/win-library/3.1")
library("parallel", lib.loc="C:/Program Files/R/R-3.1.0/library")
library("reshape2", lib.loc="C:/Users/thinkingfly/Documents/R/win-library/3.1")
library("ggplot2", lib.loc="C:/Users/thinkingfly/Documents/R/win-library/3.1")
library("lattice", lib.loc="C:/Program Files/R/R-3.1.0/library")
library("effects", lib.loc="~/R/win-library/3.1")
require ("lattice")
library("lsmeans", lib.loc="~/R/win-library/3.1")

#root_path<-"C:/Users/thinkingfly/Desktop/Auditory Hallucination/meta8mm_all/AAL_WITH_GR/"
#root_path<-"C:/Users/thinkingfly/Desktop/Auditory Hallucination/meta8mm_all/WITH_GR_no_ones/"
#root_path<-"C:/Users/thinkingfly/Desktop/Auditory Hallucination/meta_ALE/"
#root_path<-"C:/Users/thinkingfly/Desktop/Auditory Hallucination/meta_4mm/"
#root_path<-"C:/Users/thinkingfly/Desktop/Auditory Hallucination/meta_ALE_newsample/"
root_path<-"I:/973temp/ROI_01_100_2012_trait_ALE/"
setwd(root_path)
############################################################
t1 <- proc.time()

data<-NULL

for (site in c("HLG","PKU6","WUHAN","XX_GE","XX_SE","ZMD","XIAN") ){
  
  data_tmp <- read.csv(paste0(root_path,site,"/data.csv"), header=F)
  nr<-nrow(data_tmp)
  data_tmp<-data.frame(site=rep(site,nr),data_tmp)
  data<-rbind(data,data_tmp)
  
}


names(data)[names(data)=="V1"]="group";
names(data)[names(data)=="V2"]="sex";
names(data)[names(data)=="V3"]="age";
names(data)[names(data)=="V4"]="g8";
names(data)[names(data)=="V5"]="panss";

data$group[data$group==1]<-'AH'
data$group[data$group==2]<-'NAH'
data$group[data$group==3]<-'NC'

data$group<-as.factor(data$group)


data$sex<-data$sex-mean(data$sex)
data$age<-data$age-mean(data$age)


proc.time() – t1



##########################################################


func <- function(x0,data){
  
  library("car", lib.loc="C:/Users/thinkingfly/Documents/R/win-library/3.1")
  library("metafor", lib.loc="C:/Users/thinkingfly/Documents/R/win-library/3.1")
  
  fit <- aov(x0~ sex+age+age:group+sex:group+group*site, data)
  
  #fit <- aov(x0~ group*site, data)
  
  tmp<-Anova(fit,type=3)
  
  if(!is.null(tmp['sex',"Pr(>F)"])){
    sex_p <- tmp['sex',"Pr(>F)"]
  }else{
    sex_p <- 999
  } 
  
  
  if(!is.null(tmp['age',"Pr(>F)"])){
    age_p <- tmp['age',"Pr(>F)"]
  }else{
    age_p <- 999
  }
  
  
  if(!is.null(tmp['group',"Pr(>F)"])){
    group_p <- tmp['group',"Pr(>F)"]
  }else{
    group_p <- 999
  }
  
  
  
  if(!is.null(tmp['site',"Pr(>F)"])){
    site_p <- tmp['site',"Pr(>F)"]
  }else{
    site_p <- 999
  }
  
  if(!is.null(tmp['sex_site',"Pr(>F)"])){
    sex_site_p <- tmp['sex:site',"Pr(>F)"]
  }else{
    sex_site_p <- 999
  }
  
  if(!is.null(tmp['age_site',"Pr(>F)"])){
    age_site_p <- tmp['age:site',"Pr(>F)"]
  }else{
    age_site_p <- 999
  }
  
  
  if(!is.null(tmp['sex_group',"Pr(>F)"])){
    sex_group_p <- tmp['sex:group',"Pr(>F)"]
  }else{
    sex_group_p <- 999
  }
  
  if(!is.null(tmp['age_group',"Pr(>F)"])){
    age_group_p <- tmp['age:group',"Pr(>F)"]
  }else{
    age_group_p <- 999
  }
  
  if(!is.null(tmp['site_group',"Pr(>F)"])){
    site_group_p <- tmp['group:site',"Pr(>F)"]
  }else{
    site_group_p <- 999
  }
  
  
  
  m0<-aggregate(x0,list(site=data$site,group=data$group),mean)
  m0<-xtabs(x~.,data=m0)
  
  n0<-aggregate(x0,list(site=data$site,group=data$group),length)
  n0<-xtabs(x~.,data=n0)
  
  sd0<-aggregate(x0,list(site=data$site,group=data$group),sd)
  sd0<-xtabs(x~.,data=sd0)
  
  es_AH_NC0<-escalc(measure="SMD", m1i=m0[,"AH"],m2i=m0[,"NC"],n1i=n0[,"AH"],n2i=n0[,"NC"],sd1i=sd0[,"AH"],sd2i=sd0[,"NC"],vtype="UB")
  meta0<-rma(as.numeric(es_AH_NC0$yi),as.numeric(es_AH_NC0$vi),method="DL")
  meta_z_AH_NC<-meta0$zval
  meta_p_AH_NC<-meta0$pval
  
  es_AH_NC0<-escalc(measure="SMD", m1i=m0[,"NAH"],m2i=m0[,"NC"],n1i=n0[,"NAH"],n2i=n0[,"NC"],sd1i=sd0[,"NAH"],sd2i=sd0[,"NC"],vtype="UB")
  meta0<-rma(as.numeric(es_AH_NC0$yi),as.numeric(es_AH_NC0$vi),method="DL")
  meta_z_NAH_NC<-meta0$zval
  meta_p_NAH_NC<-meta0$pval
  
  es_AH_NC0<-escalc(measure="SMD", m1i=m0[,"AH"],m2i=m0[,"NAH"],n1i=n0[,"AH"],n2i=n0[,"NAH"],sd1i=sd0[,"AH"],sd2i=sd0[,"NAH"],vtype="UB")
  meta0<-rma(as.numeric(es_AH_NC0$yi),as.numeric(es_AH_NC0$vi),method="DL")
  meta_z_AH_NAH<-meta0$zval
  meta_p_AH_NAH<-meta0$pval
  
  output<-list(sex=sex_p,
               age=age_p,
               group=group_p,
               site=site_p,
               sex_site=sex_site_p,
               age_site=age_site_p,
               sex_group=sex_group_p,
               age_group=age_group_p,
               site_group=site_group_p,
               meta_z_AH_NC=meta_z_AH_NC,
               meta_p_AH_NC=meta_p_AH_NC,
               meta_z_NAH_NC=meta_z_NAH_NC,
               meta_p_NAH_NC=meta_p_NAH_NC,
               meta_z_AH_NAH=meta_z_AH_NAH,
               meta_p_AH_NAH=meta_p_AH_NAH
               )
  
  return(output)
  
  #forest(res,slab=levels(data$site))
}

## paralell 
# ptm <- proc.time()
# cl.cores <- detectCores()
# cl <- makeCluster(cl.cores)
# clusterExport(cl, c("data"), envir=environment()) 
# out<-parApply(cl=cl,data[,7:8],2,fun,data)
# stopCluster(cl)
# proc.time() - ptm

xyplot(data[,10]~data$site)


ptm <- proc.time()
out<-apply(data[,7:length(data)],2,func,data)
out2<-melt(out)
out3<-unstack(out2,value~L2)
write.csv(data.frame(out3),file=paste0(root_path,"stat.csv"),quote=F,row.names=F)
proc.time() - ptm

save.image("stat.RData")

#load("stat.RData")

sex<-out3$sex
age<-out3$age
group<-out3$group
site<-out3$site
sex_site<-out3$sex_site
age_site<-out3$age_site
sex_group<-out3$sex_group
age_group<-out3$age_group
site_group<-out3$site_group


meta_z_AH_NC<-out3$meta_z_AH_NC
meta_p_AH_NC<-out3$meta_p_AH_NC
meta_z_NAH_NC<-out3$meta_z_NAH_NC
meta_p_NAH_NC<-out3$meta_p_NAH_NC
meta_z_AH_NAH<-out3$meta_z_AH_NAH
meta_p_AH_NAH<-out3$meta_p_AH_NAH


## variance equality test
bart_group<-c(1,1)
bart_site<-c(1,1)

for (i in 7:length(data)){
  print(i)
  bart_group[i-6]<-bartlett.test(data[,i]~data$group)$p.value
  bart_site[i-6]<-bartlett.test(data[,i]~data$site)$p.value
}

which(bart_group<0.05)
which(bart_site<0.05)

## variance equality test
leve_group<-c(1,1)
leve_site<-c(1,1)

for (i in 7:length(data)){
  print(i)
  leve_group[i-6]<-unlist(leveneTest(data[,i]~data$group)["Pr(>F)"])[1]
  leve_site[i-6]<-unlist(leveneTest(data[,i]~data$site)["Pr(>F)"])[1]
}

which(leve_group<0.05)
which(leve_site<0.05)

## normality test
nor_test_AH<-c(1,1)
nor_test_NAH<-c(1,1)
nor_test_NC<-c(1,1)
for (i in 7:length(data)){
  print(i)
  nor_test_AH[i-6]<-shapiro.test(data[data$group=="AH",i])$p.value
  nor_test_NAH[i-6]<-shapiro.test(data[data$group=="NAH",i])$p.value
  nor_test_NC[i-6]<-shapiro.test(data[data$group=="NC",i])$p.value
}
which(nor_test_AH<0.05)
which(nor_test_NAH<0.05)
which(nor_test_NC<0.05)

qqnorm(data[data$group=="AH"&data$site=="HLG",10])
qqline(data[data$group=="AH"&data$site=="HLG",10])

qqnorm(data[data$group=="AH"&data$site=="ZMD","age"])
qqline(data[data$group=="AH"&data$site=="ZMD","age"])

shapiro.test(data[data$site=="HLG",10])

kruskal.test(data[,10], data$group)

pairwise.t.test(data[,10],data$group,p.adj="fdr")

###############
which(age<0.05)
which(sex<0.05)
which(group<0.05)
which(site<0.05)
which(age_site<0.05)
which(sex_site<0.05)
which(age_group<0.05)
which(sex_group<0.05)
which(site_group<0.05)


format(group[which(group<0.05)],digits=2)
format(site_group[which(group<0.05)],digits=2)

Alpha=0.05
adjusted_method="none"
sink(paste0(root_path,"ANOVA_results.txt"),append=T)
print(paste0("***********",adjusted_method, "adjusted p value of group effect************"))
print(paste0(adjusted_method," adjusted p value of group effect"))
group_adj<-p.adjust(group,method=adjusted_method)
which(group_adj<Alpha)
print(paste0(adjusted_method," adjusted p value of group effect with no site_group interaction"))
intersect(which(site_group>=Alpha),which(group_adj<Alpha))
sink()

# l<-length(data)-6
# ss<-squareform(c(1:l*(l-1)))
# which(ss==1)

## 年龄相关系数
r_est<-c(1,1)
r_p<-c(1,1)
for (i in 7:length(data)){
  cc<-cor.test(data[,i],data$age)
  r_est[i-6]<-cc$estimate
  r_p[i-6]<-cc$p.value
}

rp_adj<-p.adjust(r_p,method="bonferroni")
which(rp_adj<0.05)
r_est[which(rp_adj<0.05)]

## 年龄和连接强度相关
scatterplot(data[,10],data$age)
xyplot(data[,10]~data$panss|data$site,data,type = c("p","r"))

## 效应值计算
sdp<-sqrt( (sd1^2*(n1-1)+sd2^2*(n2-1))/(n1+n2-2) )
d<-(m1-m2)/sdp
Vd<-(n1 + n2)/(n1*n2) + d^2/(2 *(n1+n2))
J<-1 - 3/(4*(n1+n2-2)-1)
es_my<-c(d,Vd)*J ##不知道方差是否乘J

# 14,25 交互作用
with(data,interaction.plot(group, site,data[,20],trace.label="site",col=rainbow(7),lwd=3) )
with(data,interaction.plot(group, site,data[,31],trace.label="site",col=rainbow(7),lwd=3) )

#无交互作用 2 4 13 24 
target<-intersect(which(site_group>=0.05),which(group_adj<0.05))
for (i in target+6){

  png(file=paste0(root_path,"Inter_FC",i-6,".PNG"), bg="transparent")
  with(data,interaction.plot(group, site,data[,i],trace.label="site",col=rainbow(7),lwd=3,ylab=paste0("mean of FC",i-6),cex.lab=1.5))
  dev.off()
}

##无交互作用T-test //2 4 13 24
target<-intersect(which(site_group>=0.05),which(group_adj<0.05))
sink(paste0(root_path,"ANOVA_results.txt"))
for (i in target+6){
  #   pairwise.t.test(data[,i],data$group,p.adj="bonferroni",alternative="greater")
  #   pairwise.t.test(data[,i],data$group,p.adj="bonferroni",alternative="less")
  
  re<-pairwise.t.test(data[,i],data$group,p.adj="bonferroni",alternative="two.sided")
  print(re)
  
  re<-aggregate(data[,i],list(group=data$group),mean)
  print(re)
}
sink()

target<-intersect(which(site_group>=0.05),which(group_adj<0.05))

i=4
fit<-aov(data[,i+6]~ sex+age+group+site, data)
anova(fit)
eff<-effect("group",fit,se=T)
plot(effect("site",fit,se=T),ylab="FC4",cex.lab=1.5,cex=3,lwd=3,fontsize=3,ps=4)
re<-cbind(eff$fit[1],eff$se[1],eff$fit[2],eff$se[2],eff$fit[3],eff$se[3])
#TukeyHSD(fit,"group")
print(lsmeans(fit, list(pairwise ~ group)), adjust = c("tukey"))
summary(glht(fit,linfct=mcp(group="Tukey")))
png(file=paste0(root_path,"Corr_panss_FC",i,".PNG"), bg="transparent")
xyplot(data[,i+6]~data$panss|data$site,data,type = c("p","r"),xlab="panss score",ylab="FC4")
dev.off()

j=0;
pp<-NULL;
rr<-NULL;
for (site in c("HLG","PKU6","WUHAN","XX_GE","XX_SE","ZMD","XIAN") ){
  r<-cor.test(data$panss[data$site==site],data[[data$site==site],i+6],method = "spearman")
  pp[site]<-r$p.value
  rr[site]<-r$estimate
}

## adjusted for age and sex correlation
data_panss<-data[!is.na(data$panss),]
reg<-lm(data_panss[,i+6]~ sex+age, data_panss)
data_panss[,i+6]<-resid(reg)

png(file=paste0(root_path,"adj_Corr_panss_FC",i,".PNG"), bg="transparent")
xyplot(data_panss[,i+6]~panss|site,data_panss,type = c("p","r"),xlab="panss score",ylab="age sex adjusted FC4")
dev.off()

pp2<-NULL;
rr2<-NULL;
for (site in c("HLG","PKU6","WUHAN","XX_GE","XX_SE","ZMD","XIAN") ){
  r<-cor.test(data_panss$panss[data_panss$site==site],data_panss[data_panss$site==site,i+6],method = "spearman")
  pp2[site]<-r$p.value
  rr2[site]<-r$estimate
}
format(rr2,digits=2)
format(pp2,digits=2)
format(cbind(rr2,pp2),digits=2)

site="XIAN"
plot(data_panss[data_panss$site==site,i+6]~data_panss$panss[data_panss$site==site],ylab=paste0("FC",i),xlab=("panss score"),cex.lab=1.5)
fitline<-lm(data_panss[data_panss$site==site,i+6]~data_panss$panss[data_panss$site==site])
abline(fitline,lwd=3)
cor.test(data_panss$panss[data_panss$site==site],data_panss[data_panss$site==site,i+6])


## adjusted for age and sex correlation
i=13
data_g8<-data[!is.na(data$g8),]
reg<-lm(data_g8[,i+6]~ sex+age, data_g8)
data_g8[,i+6]<-resid(reg)

png(file=paste0(root_path,"adj_Corr_g8_FC",i,".PNG"), bg="transparent")
xyplot(data_g8[,i+6]~g8|site,data_g8,type = c("p","r"),xlab="g8 score",ylab="age sex adjusted FC4")
dev.off()

pp2<-NULL;
rr2<-NULL;
for (site in c("HLG","PKU6","WUHAN","XX_GE","XX_SE","ZMD","XIAN") ){
  r<-cor.test(data_g8$g8[data_g8$site==site],data_g8[data_g8$site==site,i+6],method = "spearman")
  pp2[site]<-r$p.value
  rr2[site]<-r$estimate
}
format(cbind(rr2,pp2),digits=2)


## CORRELATION
p_panss<-c(1,1)
r_panss<-c(1,1)
p_g8<-c(1,1)
r_g8<-c(1,1)
for (i in 1:(length(data)-6)){
  print(i)
  r<-cor.test(data$panss[!is.na(data$panss)],data[!is.na(data$panss),i+6],method = "spearman")
  p_panss[i]<-r$p.value
  r_panss[i]<-r$estimate
  
  r<-cor.test(data$g8[!is.na(data$g8)],data[!is.na(data$g8),i+6],method = "spearman")
  p_g8[i]<-r$p.value
  r_g8[i]<-r$estimate
  #scatterplot(data$panss[!is.na(data$panss)],data[!is.na(data$panss),i+6],reg.line=T,lwd=3,smooth=T)
  #scatterplot(data$g8[!is.na(data$g8)],data[!is.na(data$g8),i+6])
  
  


}

which(p_panss<0.05)
r_panss[which(p_panss<0.05)]
which(p_g8<0.05)
r_g8[which(p_g8<0.05)]


### FC ~ PANSS ####
target<-intersect(which(site_group>=0.05),which(group_adj<0.05))
for (i in target){
  png(file=paste0(root_path,"Corr_panss_FC",i,".PNG"), bg="transparent")
  par(mfrow=c(4,2))
  plot(data[!is.na(data$panss),i+6]~data$panss[!is.na(data$panss)],ylab=paste0("FC",i),xlab=("panss score"),cex.lab=1.5)
  fitline<-lm(data[!is.na(data$panss),i+6]~data$panss[!is.na(data$panss)])
  abline(fitline,lwd=3)
  text(x=120, y = max(data[!is.na(data$panss),i+6])-0.3, labels = paste0("r=",format(r_panss[i],digits=2),", p=",format(p_panss[i],digits=2)), adj = c(1,1),
       pos = 4, offset = 0.5, vfont = NULL,
       cex = 1.2, col = NULL, font = 1)
  dev.off()
#   pp<-ggplot(NULL, aes( x=data$panss[!is.na(data$panss)], y=data[!is.na(data$panss),i+6] ) ) +
#     geom_point(shape=3) +    # Use hollow circles
#     geom_smooth(method=lm,   # Add linear regression lines
#                 se=T,    # Don't add shaded confidence region
#                 fullrange=TRUE,size=1.5,weight=2) # Extend regression lines
#   ggsave(pp,file=paste0(root_path,"Corr_panss_FC",i,".PNG"), bg="transparent")
  
}







### FC ~ G8 ####
target<-intersect(which(site_group>=0.05),which(group_adj<0.05))
for (i in target){
  png(file=paste0(root_path,"Corr_g8_FC",i,".PNG"), bg="transparent")
  plot(data[!is.na(data$g8),i+6]~data$g8[!is.na(data$g8)],ylab=paste0("FC",i),xlab=("g8 score"),cex.lab=1.5)
  fitline<-lm(data[!is.na(data$g8),i+6]~data$g8[!is.na(data$g8)])
  abline(fitline,lwd=3)
  text(x=35, y = max(data[!is.na(data$g8),i+6])-0.3, labels = paste0("r=",format(r_g8[i],digits=2),", p=",format(p_g8[i],digits=2)), adj = c(1,1),
                                     pos = 4, offset = 0.5, vfont = NULL,
                                     cex = 1.2, col = NULL, font = 1)
  dev.off()
  #   pp<-ggplot(NULL, aes( x=data$g8[!is.na(data$g8)], y=data[!is.na(data$g8),i+6] ) ) +
  #     geom_point(shape=3) +    # Use hollow circles
  #     geom_smooth(method=lm,   # Add linear regression lines
  #                 se=T,    # Don't add shaded confidence region
  #                 fullrange=TRUE,size=1.5,weight=2) # Extend regression lines
  #   ggsave(pp,file=paste0(root_path,"Corr_g8_FC",i,".PNG"), bg="transparent")
  
}

## bar plot
for (i in c(2,4,13,24)+6){
  m0<-aggregate(data[,i],list(site=data$site,group=data$group),mean)
  m0<-xtabs(x~.,data=m0)
  
  n0<-aggregate(data[,i],list(site=data$site,group=data$group),length)
  n0<-xtabs(x~.,data=n0)
  
  sd0<-aggregate(data[,i],list(site=data$site,group=data$group),sd)
  sd0<-xtabs(x~.,data=sd0)
  
  m1<-aggregate(data[,i],list(group=data$group),mean)
  n1<-aggregate(data[,i],list(group=data$group),length)
  sd1<-aggregate(data[,i],list(group=data$group),sd)
  se1<-sd1["x"]/sqrt(n1["x"])
  re<-cbind(m1$x,se1$x)
  write.table(t(as.vector(t(re))),file=paste0(root_path,"m.txt"),quote=F,row.names=F,col.names=F,append=TRUE)
}

## meta analysis
Alpha<-0.05

p_new<-p.adjust(meta_p_AH_NC,method="bonferroni")
which(p_new<Alpha)
p_new[which(p_new<Alpha)]
meta_z_AH_NC[which(p_new<Alpha)]

p_new<-p.adjust(meta_p_NAH_NC,method="bonferroni")
which(p_new<Alpha)
p_new[which(p_new<Alpha)]
meta_z_NAH_NC[which(p_new<Alpha)]

p_new<-p.adjust(meta_p_AH_NAH,method="bonferroni")
which(p_new<Alpha)
p_new[which(p_new<Alpha)]
meta_z_AH_NAH[which(p_new<Alpha)]

p_new<-p.adjust(meta_p_AH_NC,method="bonferroni")
for (i in which(p_new<0.05)+6){
  m0<-aggregate(data[,i],list(site=data$site,group=data$group),mean)
  m0<-xtabs(x~.,data=m0)
  
  n0<-aggregate(data[,i],list(site=data$site,group=data$group),length)
  n0<-xtabs(x~.,data=n0)
  
  sd0<-aggregate(data[,i],list(site=data$site,group=data$group),sd)
  sd0<-xtabs(x~.,data=sd0)
  
  es<-escalc(measure="SMD", m1i=m0[,"AH"],m2i=m0[,"NC"],n1i=n0[,"AH"],n2i=n0[,"NC"],sd1i=sd0[,"AH"],sd2i=sd0[,"NC"],vtype="UB")
  meta0<-rma(as.numeric(es$yi),as.numeric(es$vi),method="DL")
  
  png(file=paste0(root_path,"Forest_FC_",i-6,"_AH_NC.PNG"), bg="transparent")
  forest(meta0,slab=(levels(data$site)),main=paste("Forest Plot of FC_",i-6,"(AH-NC)"))
  dev.off()
}


p_new<-p.adjust(meta_p_NAH_NC,method="bonferroni")
for (i in which(p_new<0.05)+6){
  m0<-aggregate(data[,i],list(site=data$site,group=data$group),mean)
  m0<-xtabs(x~.,data=m0)
  
  n0<-aggregate(data[,i],list(site=data$site,group=data$group),length)
  n0<-xtabs(x~.,data=n0)
  
  sd0<-aggregate(data[,i],list(site=data$site,group=data$group),sd)
  sd0<-xtabs(x~.,data=sd0)
  
  es<-escalc(measure="SMD", m1i=m0[,"NAH"],m2i=m0[,"NC"],n1i=n0[,"NAH"],n2i=n0[,"NC"],sd1i=sd0[,"NAH"],sd2i=sd0[,"NC"],vtype="UB")
  meta0<-rma(as.numeric(es$yi),as.numeric(es$vi),method="DL")
  
  png(file=paste0(root_path,"Forest_FC_",i-6,"_NAH_NC.PNG"), bg="transparent")
  forest(meta0,slab=(levels(data$site)),main=paste("Forest Plot of FC_",i-6,"(NAH-NC)"))
  dev.off()
}

p_new<-p.adjust(meta_p_NAH_NC,method="bonferroni")

i=25
  mage<-aggregate(data$age,list(site=data$site,group=data$group),mean)
  mage<-xtabs(x~.,data=mage)

  msex<-aggregate(data$sex,list(site=data$site,group=data$group),mean)
  msex<-xtabs(x~.,data=msex)

  m0<-aggregate(data[,i],list(site=data$site,group=data$group),mean)
  m0<-xtabs(x~.,data=m0)
  
  n0<-aggregate(data[,i],list(site=data$site,group=data$group),length)
  n0<-xtabs(x~.,data=n0)
  
  sd0<-aggregate(data[,i],list(site=data$site,group=data$group),sd)
  sd0<-xtabs(x~.,data=sd0)
  
  es<-escalc(measure="SMD", m1i=m0[,"AH"],m2i=m0[,"NAH"],n1i=n0[,"AH"],n2i=n0[,"NAH"],sd1i=sd0[,"AH"],sd2i=sd0[,"NAH"],vtype="UB")
  meta0<-rma(as.numeric(es$yi),as.numeric(es$vi),method="DL") #mods=cbind((mage[,1]-mage[,2]),(msex[,1]-msex[,2]))
  
  png(file=paste0(root_path,"Forest_FC_",i-6,"_AH_NAH.PNG"), bg="transparent")
  forest(meta0,slab=(levels(data$site)),main=paste("Forest Plot of FC_",i-6,"(AH-NAH)"))
  dev.off()



## outier detection
outlie<-rep(0,nrow(data))
for (i in 7:length(data)){
  
  out<-boxplot(data[,i])$out
  outlie[data[,i] %in% out]<-NA
  # boxplot(data[!is.na(outlie),i])
}

## bar plot

m0<-aggregate(data[!is.na(data$panss),"panss"],list(site=data[!is.na(data$panss),"site"],group=data[!is.na(data$panss),"group"]),mean)
m0<-xtabs(x~.,data=m0)

n0<-aggregate(data[!is.na(data$panss),"panss"],list(site=data[!is.na(data$panss),"site"],group=data[!is.na(data$panss),"group"]),length)
n0<-xtabs(x~.,data=n0)

sd0<-aggregate(data[!is.na(data$panss),"panss"],list(site=data[!is.na(data$panss),"site"],group=data[!is.na(data$panss),"group"]),sd)
sd0<-xtabs(x~.,data=sd0)
se0<-sd0/sqrt(n0)
re<-cbind(m0[,"AH"],se0[,"AH"],m0[,"NAH"],se0[,"NAH"],m0[,"NC"],se0[,"NC"])
write.table(re,file=paste0(root_path,"panss.txt"),sep="\t",quote=F,row.names=F,col.names=F,append=F)

#boxplot(data[!is.na(data$panss),"panss"]*data[!is.na(data$panss),"site"]+data[!is.na(data$panss),"group"])
png(file=paste0(root_path,"panss_boxplot.PNG"), bg="transparent")
boxplot(data$panss~data$group*data$site,col=rainbow(3))
dev.off()

png(file=paste0(root_path,"g8_boxplot.PNG"), bg="transparent")
boxplot(data$g8~data$group*data$site,col=rainbow(3))
dev.off()

TukeyHSD(fit, which="group",ordered = FALSE, conf.level = 0.95)

dat_M<-data[,c("age","sex","group")]
dat_M$group<-as.numeric(dat_M$group)
dat_M$group[dat_M$group==3]<-0
m.out<-matchit(group~age+sex,method="nearest",data=dat_M)

i=20
model<-lmer(data[,i+6]~sex+age+group+(1|site),data=data)
summary(model)
anova(model)
st<-step(model)
plot(st)
difflsmeans(model,test.eff="group")
lsmeans(model,list(pairwise~group))
