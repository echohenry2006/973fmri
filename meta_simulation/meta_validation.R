# meta anlalysis validation
# S ~ N(mu0, std0)
# S_i ~ N(mui, stdi)
# mue ~ N(0,stde)

# prepare simulation data

library("metafor", lib.loc="C:/Users/thinkingfly/Documents/R/win-library/3.1")
library(sm)
library(reshape2)
library(colorspace)

randf<-function(x,mu0,sd,N){
  res <- rnorm(N,x+mu0,sd)
}


simulate<-function(U_tot_exp=100,D_tot_exp=1,U_tot_con=100.05,D_tot_con=1,
               U_err=0,D_err=0.1,N_sample=1000,n_sample=50,plot.forest=FALSE,print.value=FALSE){
    
  s_all_exp=list()
  s_all_con= list()
    
  ram_seed = rnorm(n_sample,U_err,D_err)
  s_all_exp=lapply(ram_seed,randf,U_tot_exp,sqrt(D_tot_exp^2+D_err^2),N_sample)
  ram_seed = rnorm(n_sample,U_err,D_err)
  s_all_con=lapply(ram_seed,randf,U_tot_con,sqrt(D_tot_con^2+D_err^2),N_sample)
  all_mean_exp = sapply(s_all_exp,mean)
  all_sd_exp = sapply(s_all_exp,sd)
  all_mean_con = sapply(s_all_con,mean)
  all_sd_con = sapply(s_all_con,sd)
  all_n_exp = rep(N_sample,n_sample)
  all_n_con = rep(N_sample,n_sample)
  # meta analysis
  es<-escalc(measure="SMD", m1i=all_mean_exp,m2i=all_mean_con,n1i=all_n_exp,
             n2i=all_n_con,sd1i=all_sd_exp,sd2i=all_sd_con,vtype="UB")
  meta0<-rma(as.numeric(es$yi),as.numeric(es$vi),method="DL")  #DL
  #par(mar = rep(2, 4))
  #par(font=1,cex=1,cex.lab=1,cex.main=1,cex.sub=1,cex.axis=1,lwd=1)
  if (plot.forest==TRUE)
    forest(meta0,xlab="SMD",mlab="RE Model for All Sites")
  if (print.value==TRUE){
    print("The pvalue is")
    print(meta0$pval)
  }
  meta0$pval
}


test_N<-function(x,Ns=500){
  pvalue <- replicate(Ns,simulate(N_sample=x))
  
}

test_n<-function(x,Ns=500){
  pvalue <- replicate(Ns,simulate(n_sample = x))
}

##### test sample size in each study 
N_sample<-c(20,50,100,200,500,1000,2000,3000,5000,6000,7000,8000,9000,10000,20000)

test_N_p<-sapply(N_sample,test_N)
colnames(test_N_p)<-as.character(N_sample)
tmp <- apply(test_N_p,c(1,2),(function (x) as.numeric(x<0.05)))
plot(colSums(tmp),type="o",col="blue",xlab="num of sample in each studies")
title(main="count of significant p(<0.05) in Ns=500 samples")


##### test sample size in each study 
n_sample<-c(7,10,15,20,40,60,80,100,150,200,250,300)

test_n_p<-sapply(n_sample,test_n)
colnames(test_n_p)<-as.character(n_sample)
tmp <- apply(test_n_p,c(1,2),(function (x) as.numeric(x<0.05)))
plot(colSums(tmp),type="o",col="blue",xlab="num of studies")
title(main="count of significant p(<0.05) in Ns=500 samples")



# set.seed(1)
# col_map <- cbind(runif(20),runif(20),runif(20))
# 
# par(mfrow=c(length(N_sample),1)) 
# par(mar=c(1,1,1,1),mgp=c(3,1,0))
# for (i in 1:length(N_sample)){
#   hist(test_N_p[,i],breaks=c(0.05,0.08,0,1,0.12,0.22,0.32,0.42,0.52,0.7,0.8,0.9),col=rgb(col_map[i,1],col_map[i,2],col_map[i,3],1),
#        xlab="meta-analysis p",,xlim=c(0,1),freq=TRUE)
# }

# p1 <- hist(test_N_p[,1],plot=FALSE)
# plot(p1,col=rgb(col_map[1,1],col_map[1,2],col_map[1,3],1/4))
# p2 <- hist(test_N_p[,2],plot=FALSE)
# plot(p2,col=rgb(col_map[2,1],col_map[2,2],col_map[2,3],1/4),add=T)

#test_N_p<-as.data.frame(melt(test_N_p,id.vars=1:2))
# plot densities 
#sm.density.compare(test_N_p$value, as.factor(test_N_p$Var2), xlab="meta-analysis p")
#title(main="Distribution by Sampe size")


