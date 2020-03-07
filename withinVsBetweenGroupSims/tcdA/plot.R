tb <- read.table("toxina.self",header=F)
tb[,1] <- as.character(tb[,1])
tb[,2] <- as.character(tb[,2])


for (i in 1:nrow(tb))
{
		tb[i,1] = as.character(strsplit(as.character(tb[i,1]),"\\.")[[1]][1])
		tb[i,2] = as.character(strsplit(as.character(tb[i,2]),"\\.")[[1]][1])

}

tb <- tb[-which(tb[,1] =="E"),]
tb <- tb[-which(tb[,2] =="E"),]

tb <- tb[-which(tb[,2] =="F"),]
tb <- tb[-which(tb[,1] =="F"),]


boxplot(

tb[intersect(which(tb[,1] == "A"),which(tb[,2] == "A")),3],tb[intersect(which(tb[,1] == "A"),which(tb[,2] != "A")),3],

tb[intersect(which(tb[,1] == "B"),which(tb[,2] == "B")),3],tb[intersect(which(tb[,1] == "B"),which(tb[,2] != "B")),3],

tb[intersect(which(tb[,1] == "C"),which(tb[,2] == "C")),3],tb[intersect(which(tb[,1] == "C"),which(tb[,2] != "C")),3],

tb[intersect(which(tb[,1] == "D"),which(tb[,2] == "D")),3],tb[intersect(which(tb[,1] == "D"),which(tb[,2] != "D")),3],

col=c("blue","gray"),names=c("A-A","A-other","B-B","B-other","C-C","C-other","D-D","D-other"),las=3
)
abline(h = 99.6,lty="dashed")
