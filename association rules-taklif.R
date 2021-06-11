install.packages('httr')
if (!file.exists("titanic.raw.rdata")) {
  library(httr)
  resp <- GET("http://www.rdatamining.com/data/titanic.raw.rdata")
  writeBin(content(resp, 'raw'), "titanic.raw.rdata")
}
load("titanic.raw.rdata")

df<-titanic.raw
#load require packages
library(plyr)
library(arulesViz)
library(arules)

tran=df[order(df$Class),]
summary(tran)
str(tran)

library(tidyr)

tr<-unite(tran,newcol,c(Class,Sex,Age,Survived),sep = ",")
head(tr)

colnames(tr)<-c("itemlist")

write.csv(tr,file = "D:/amar baray elm data/Conditional probability/association rules/TAKLIF/tr.csv",quote = FALSE, row.names = TRUE)

tobj=read.transactions(file ="D:/amar baray elm data/Conditional probability/association rules/TAKLIF/tr.csv",rm.duplicates = TRUE ,format = "basket",sep = ",", cols = 1 )

head(tobj)
taitanic_rules<-apriori(tobj,parameter = list(minlen=4,sup=0.001,conf=0.05))


inspect(head(sort(taitanic_rules,by="lift"),20))


plot(head(sort(taitanic_rules,by="lift"),20),method = "graph")


plot(taitanic_rules, method = "scatterplot",jitter=0)

plot(head(sort(taitanic_rules,by="lift"),20),method = "paracoord")
