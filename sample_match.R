rm(list = ls())
require(gdata)
require(xlsx)
require(MatchIt)



site_all=c("HLG", "PKU6", "XIAN", "XX_GE", "XX_SE", "ZMD", "WUHAN");

root_path<-"C:/Users/thinkingfly/Desktop/new/"



df=read.xlsx2(file="C:/Users/thinkingfly/Desktop/new/multi_sites_use_eq_1_panss_scores_CRF.xlsx",
              sheetIndex=1, header=TRUE) 

df$Group<-as.factor(as.character(df$Group))
df$Age<-as.numeric(as.character(df$Age))
df$Sex<-as.factor(df$Sex)

df$a4<-as.factor(df$a4) #1 han 2 other
names(df)[names(df)=="a4"]<-"Race"

df$a5<-as.numeric(df$a5)
names(df)[names(df)=="a5"]<-"Education"

df$a12<-as.factor(df$a12)
names(df)[names(df)=="a12"]<-"Subtype"

df$a13<-as.factor(as.numeric(df$a13))
names(df)[names(df)=="a13"]<-"FES" # 1 NC 2 FES 3 Non-FES

df$a14_1<-as.numeric(df$a14_1)
names(df)[names(df)=="a14_1"]<-"course_year"

df$a14_2<-as.numeric(df$a14_2)
names(df)[names(df)=="a14_2"]<-"course_month"

df$b1<-as.factor(df$b1)
names(df)[names(df)=="b1"]<-"handness" # 1 right 2 mix 5 left
df$g8[df$g8==""]<-NA
df$g8<-as.numeric(df$g8)

df$P3[df$P3==""]<-NA
df$P3<-as.numeric(df$P3)

df$PANSS_p[df$PANSS_p==""]<-NA
df$PANSS_p<-as.numeric(df$PANSS_p)

df$PANSS_n[df$PANSS_n==""]<-NA
df$PANSS_n<-as.numeric(df$PANSS_n)

df$PANSS_g[df$PANSS_g==""]<-NA
df$PANSS_g<-as.numeric(df$PANSS_g)

df$PANSS_total[df$PANSS_total==""]<-NA
df$PANSS_total<-as.numeric(df$PANSS_total)


course_total<-df$course_year*12+df$course_month

df<-cbind(df,course_total)

df$final<-0


df_fes<-subset(df,Race==1&handness==1,select=c(Filter,Sex,Age,Group,Race,Education,course_year,course_month,handness,FES,Subtype))
aggregate(df_fes$Group,list(group=df_fes$Group,site=df_fes$Filter),length)
###########################################################################
final<-rep(c(0),nrow(df))
# "HLG" "PKU6" "XIAN" "XX_GE" "XX_SE" "ZMD" "WUHAN"

# ---------------------------------PKU6------------------------------#
site="PKU6"

rm(df_new)
rm(m.out)
df_new<-subset(df,Filter==site&Race==1&handness==1,select=c(Sex,Age,Group,Race,Education,course_year,course_month,handness,FES,Subtype))
formu<-~Age+Sex+Education

df_new$treat=NA
df_new$treat[df_new$Group=="NC"]=0
df_new$treat[df_new$Group=="SZ"]=1

m.out = matchit(treat ~ Age + Sex , 
                data = df_new, method = "nearest", discard="none",caliper=0.7,
                ratio = 1,reestimate=T) 
summary(m.out) 
# plot(m.out, type = "jitter") 
# plot(m.out, type = "hist")
m.data<-match.data(m.out)
#aggregate(m.data$Age,list(group=m.data$Group),mean)
t.test(m.data$Age~m.data$Group,p.adj="none")
t.test(m.data$Education~m.data$Group,p.adj="none")
ta<-table(m.data$Sex,m.data$Group)
ta
chisq.test(ta[,1:2])

lef<-as.numeric(row.names(m.data))
df$final[lef]<-1




#------------------------------XIAN-----------------------------#

site="XIAN"

rm(df_new)
rm(m.out)
df_new<-subset(df,Filter==site&Race==1&handness==1,select=c(Sex,Age,Group,Race,Education,course_year,course_month,handness,FES,Subtype))
formu<-~Age+Sex+Education

df_new$treat=NA
df_new$treat[df_new$Group=="SZ"]=0
df_new$treat[df_new$Group=="NC"]=1

m.out = matchit(treat ~ Age + Sex , 
                data = df_new, method = "nearest", discard="none",caliper=0.25,
                ratio = 2,reestimate=T) 
summary(m.out) 
# plot(m.out, type = "jitter") 
# plot(m.out, type = "hist")
m.data<-match.data(m.out)
#aggregate(m.data$Age,list(group=m.data$Group),mean)
t.test(m.data$Age~m.data$Group,p.adj="none")
t.test(m.data$Education~m.data$Group,p.adj="none")
ta<-table(m.data$Sex,m.data$Group)
ta
chisq.test(ta[,1:2])

lef<-as.numeric(row.names(m.data))
df$final[lef]<-1



#------------------------------XX_GE-----------------------------#

site="XX_GE"

rm(df_new)
rm(m.out)
df_new<-subset(df,Filter==site&Race==1&handness==1,select=c(Sex,Age,Group,Race,Education,course_year,course_month,handness,FES,Subtype))
formu<-~Age+Sex+Education

df_new$treat=NA
df_new$treat[df_new$Group=="SZ"]=1
df_new$treat[df_new$Group=="NC"]=0

m.out = matchit(treat ~ Age + Sex +Education, 
                data = df_new, method = "nearest", discard="none",caliper=0.7,
                ratio = 2,reestimate=T) 
summary(m.out) 
# plot(m.out, type = "jitter") 
# plot(m.out, type = "hist")
m.data<-match.data(m.out)
#aggregate(m.data$Age,list(group=m.data$Group),mean)
t.test(m.data$Age~m.data$Group,p.adj="none")
t.test(m.data$Education~m.data$Group,p.adj="none")
ta<-table(m.data$Sex,m.data$Group)
ta
chisq.test(ta[,1:2])

lef<-as.numeric(row.names(m.data))
df$final[lef]<-1




#------------------------------XX_SE-----------------------------#

site="XX_SE"

rm(df_new)
rm(m.out)
df_new<-subset(df,Filter==site&Race==1&handness==1,select=c(Sex,Age,Group,Race,Education,course_year,course_month,handness,FES,Subtype))
formu<-~Age+Sex+Education

df_new$treat=NA
df_new$treat[df_new$Group=="NC"]=0
df_new$treat[df_new$Group=="SZ"]=1

m.out = matchit(treat ~ Age + Sex , 
                data = df_new, method = "nearest", discard="none",caliper=0.5,
                ratio = 1,reestimate=T) 
summary(m.out) 
# plot(m.out, type = "jitter") 
# plot(m.out, type = "hist")
m.data<-match.data(m.out)
#aggregate(m.data$Age,list(group=m.data$Group),mean)
t.test(m.data$Age~m.data$Group,p.adj="none")
t.test(m.data$Education~m.data$Group,p.adj="none")
ta<-table(m.data$Sex,m.data$Group)
ta
chisq.test(ta[,1:2])

lef<-as.numeric(row.names(m.data))
df$final[lef]<-1





#------------------------------ZMD-----------------------------#

site="ZMD"

rm(df_new)
rm(m.out)
df_new<-subset(df,Filter==site&Race==1&handness==1,select=c(Sex,Age,Group,Race,Education,course_year,course_month,handness,FES,Subtype))
formu<-~Age+Sex+Education

df_new$treat=NA
df_new$treat[df_new$Group=="SZ"]=1
df_new$treat[df_new$Group=="NC"]=0

m.out = matchit(treat ~ Age + Sex , 
                data = df_new, method = "nearest", discard="both",caliper=0.5,
                ratio = 1,reestimate=T) 
summary(m.out) 
# plot(m.out, type = "jitter") 
# plot(m.out, type = "hist")
m.data<-match.data(m.out)
#aggregate(m.data$Age,list(group=m.data$Group),mean)
t.test(m.data$Age~m.data$Group,p.adj="none")
t.test(m.data$Education~m.data$Group,p.adj="none")
ta<-table(m.data$Sex,m.data$Group)
ta
chisq.test(ta[,1:2])

lef<-as.numeric(row.names(m.data))
df$final[lef]<-1


#------------------------------HLG-----------------------------#

site="HLG"

rm(df_new)
rm(m.out)
df_new<-subset(df,Filter==site&Race==1&handness==1,select=c(Sex,Age,Group,Race,Education,course_year,course_month,handness,FES,Subtype))
formu<-~Age+Sex+Education

df_new$treat=NA
df_new$treat[df_new$Group=="SZ"]=0
df_new$treat[df_new$Group=="NC"]=1

m.out = matchit(treat ~ Age + Sex , 
                data = df_new, method = "nearest", discard="both",caliper=0.5,
                ratio = 2,reestimate=T) 
summary(m.out) 
# plot(m.out, type = "jitter") 
# plot(m.out, type = "hist")
m.data<-match.data(m.out)
#aggregate(m.data$Age,list(group=m.data$Group),mean)
t.test(m.data$Age~m.data$Group,p.adj="none")
t.test(m.data$Education~m.data$Group,p.adj="none")
ta<-table(m.data$Sex,m.data$Group)
ta
chisq.test(ta[,1:2])

lef<-as.numeric(row.names(m.data))
df$final[lef]<-1

#------------------------------WUHAN-----------------------------#

site="WUHAN"

rm(df_new)
rm(m.out)
df_new<-subset(df,Filter==site&Race==1&handness==1,select=c(Sex,Age,Group,Race,Education,course_year,course_month,handness,FES,Subtype))
formu<-~Age+Sex+Education

df_new$treat=NA
df_new$treat[df_new$Group=="SZ"]=1
df_new$treat[df_new$Group=="NC"]=0

m.out = matchit(treat ~ Age + Sex , 
                data = df_new, method = "nearest", discard="both",caliper=0.5,
                ratio = 2,reestimate=T) 
summary(m.out) 
# plot(m.out, type = "jitter") 
# plot(m.out, type = "hist")
m.data<-match.data(m.out)
#aggregate(m.data$Age,list(group=m.data$Group),mean)
t.test(m.data$Age~m.data$Group,p.adj="none")
t.test(m.data$Education~m.data$Group,p.adj="none")
ta<-table(m.data$Sex,m.data$Group)
ta
chisq.test(ta[,1:2])

lef<-as.numeric(row.names(m.data))
df$final[lef]<-1


#write.csv(data.frame(df2),file=paste0(root_path,"FES_match.csv"),quote=F,row.names=F)
write.xlsx(x = data.frame(df), file=paste0(root_path,"ALL_match_SZ_NC.xlsx"), row.names = FALSE)

# check

df3=read.xlsx2(file=paste0(root_path,"ALL_match_SZ_NC.xlsx"),sheetIndex=1, header=TRUE)
df3$Education<-as.numeric(as.character(df3$Education))
df3$Age<-as.numeric(as.character(df3$Age))
df3$course_total<-as.numeric(as.character(df3$course_total))
df3$Sex<-as.factor(df3$Sex)

aggregate(df3$Group,list(group=df3$Group,site=df3$Filter),length)

df4<-subset(df3,final==1,select=c(Group,Filter))
aggregate(df4$Group,list(group=df4$Group,site=df4$Filter),length)

site_all=c( "HLG","PKU6", "XIAN", "XX_GE", "XX_SE", "ZMD","WUHAN" )
age_p<-c(1,1)
edu_p<-c(1,1)
sex_p<-c(1,1)

i=1
for (i in 1:length(site_all)){
  site<-site_all[i]
  df_new<-subset(df3,Filter==site&final==1,select=c(Name,Sex,Age,Group,Race,Education,course_year,course_month,course_total,handness,FES,Subtype))
  
  df_new$Group=as.factor(as.character(df_new$Group))
  aggregate(df_new$Group,list(group=df_new$Group),length)
  
  aggregate(df_new$Age,list(sex=df_new$Sex,group=df_new$Group),length)
  aggregate(df_new$Age,list(group=df_new$Group),mean)
  
  tes<-t.test(Age~Group,data=df_new)
  age_p[i]<-min(tes$p.value,na.rm=T)
  #tes<-t.test(df_new$Education,df_new$Group,p.adj="none")
  #edu_p[i]<-tes$p.value
  #t.test(df_new$course_total~df_new$Group,p.adj="none")
  
  ta<-table(df_new$Sex,df_new$Group)
  ta
  tes<-chisq.test(ta)
  sex_p[i]<-tes$p.value
  
  write.table(df_new$Name[df_new$Group=="NC"],paste0(root_path,"ALL_match/",site,"_NC.txt"), sep="\n",row.names = F,col.names = F,quote=F)
  write.table(df_new$Name[df_new$Group=="SZ"],paste0(root_path,"ALL_match/",site,"_SZ.txt"), sep="\n",row.names = F,col.names = F,quote=F)
  
}

age_p
sex_p

