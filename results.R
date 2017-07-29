library(data.table)
library(Hmisc)
library(boot)
library(tidyr)
library(dplyr)
######



# Prediction data (For F1)
df <- fread("results/model_results.csv")
# Posterior predictions (For LL)
lldf <- fread("results/model_results_ll.csv")
lldf[,none_prob:=1-(clinton_prob+trump_prob)]
lldf[, logloss := ifelse(actual=="Trump", log(trump_prob), ifelse(actual=="Clinton", log(clinton_prob),log(none_prob)))]

df[,ind := 1:.N, by=model]
lldf[,ind := 1:.N, by=model]

f1 <- function(y,preds){
  tab <- table(preds,y)
  p <- (tab[2,2])/(tab[2,1]+tab[2,2])
  r <- (tab[2,2])/(tab[1,2]+tab[2,2])
  return((2*p*r)/(p+r))
}

avg_f1 <- function(actual,predicted){
  f1_clint <- f1(factor(predicted == "Clinton"),factor(actual == "Clinton"))
  f1_trump <- f1(factor(predicted == "Trump"),factor(actual == "Trump"))
  return( (f1_clint + f1_trump )/2)
}

diff_avg_f1 <- function(dft,indices, col1, col2){
  dft <- dft[indices,]
  return(avg_f1(dft$actual,dft[,get(col1)]) - avg_f1(dft$actual,dft[,get(col2)]))
}

# general summary statistics
arrange(df[,avg_f1(actual,predicted),by=model],-V1)
arrange(lldf[,mean(logloss),by=model],-V1)

 
# Some choice bootstrap tests for F1, mann-whitney for logloss for comparing baseline models
df_spr <- spread(df, model, predicted)

r <- boot(df_spr, statistic=diff_avg_f1,R=1000,col1="poltweet",col2="fulluser")
boot.ci(r, type="bca")
wilcox.test(lldf[model=="poltweet"]$logloss, lldf[model=="fulluser"]$logloss,alternative="greater")


# Compare Constance to the best baseline model
r <- boot(df_spr, statistic=diff_avg_f1,R=1000,col1="Full",col2="All")
boot.ci(r, type="bca")
wilcox.test(lldf[model=="Full"]$logloss, lldf[model=="poltweet"]$logloss,alternative="greater")


r <- boot(df_spr, statistic=diff_avg_f1,R=1000,col1="One Annotator",col2="All")
boot.ci(r, type="bca")
wilcox.test(lldf[model=="One Annotator"]$logloss, lldf[model=="poltweet"]$logloss,alternative="greater")


r <- boot(df_spr, statistic=diff_avg_f1,R=1000,col1="One Context",col2="All")
boot.ci(r, type="bca")
wilcox.test(lldf[model=="One Context"]$logloss, lldf[model=="poltweet"]$logloss,alternative="greater")

r <- boot(df_spr, statistic=diff_avg_f1,R=1000,col1="Pol Tweet Context",col2="All")
boot.ci(r, type="bca")
wilcox.test(lldf[model=="Pol Tweet Context"]$logloss, lldf[model=="poltweet"]$logloss,alternative="greater")


# 3
r <- boot(df_spr, statistic=diff_avg_f1,R=1000,col1="Full",col2="One Annotator")
boot.ci(r, type="bca")
wilcox.test(lldf[model=="Full"]$logloss, lldf[model=="One Annotator"]$logloss,alternative="greater")

# 2 
r <- boot(df_spr, statistic=diff_avg_f1,R=1000,col1="Full",col2="One Context")
boot.ci(r, type="bca")
wilcox.test(lldf[model=="Full"]$logloss, lldf[model=="One Context"]$logloss,alternative="greater")

# 1 
r <- boot(df_spr, statistic=diff_avg_f1,R=1000,col1="Full",col2="Pol Tweet Context")
boot.ci(r, type="bca")
wilcox.test(lldf[model=="Full"]$logloss, lldf[model=="Pol Tweet Context"]$logloss,alternative="greater")


# Model poltweet vs poltweet
r <- boot(df_spr, statistic=diff_avg_f1,R=1000,col1="Pol Tweet Context",col2="poltweet")
boot.ci(r, type="bca")
wilcox.test(lldf[model=="Pol Tweet Context"]$logloss, lldf[model=="poltweet"]$logloss,alternative="greater")





r <- boot(df_spr, statistic=diff_avg_f1,R=1000,col1="All",col2="poltweet")
boot.ci(r, type="bca")
wilcox.test(lldf[model=="All"]$logloss, lldf[model=="poltweet"]$logloss,alternative="greater")




#### Plot Gamma
d <- fread("results/final_gamma.csv")
d[d$V2 == "A_None"]$V2 = "Neutral"
d[d$V3 == "A_None"]$V3 = "Neutral"
setnames(d,c("Context","overall","context_label","Value"))
d$Context <- factor(d$Context,levels=c("none","partialuser","fulluser","prevtweet","poltweet","polparty"),
                    labels=c("No Context","Partial Profile","Full Profile","Previous Tweets",
                             "Political Tweets", "Political Party"))

d$context_label <- factor(d$context_label, levels=c("Trump","Neutral","Clinton"))
p <- ggplot(d, aes(context_label,overall,fill=Value)) + geom_tile() + scale_fill_gradient(low="white",high="red") + facet_wrap(~Context)
p <- p + ylab("Overall Label of Tweet") + xlab("Context-Specific Label of Tweet")
p
