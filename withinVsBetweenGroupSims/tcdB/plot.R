tb <- read.table("~/toxinb.self",header=F)
tb[,1] <- as.character(tb[,1])
tb[,2] <- as.character(tb[,2])


for (i in 1:nrow(tb))
{
		tb[i,1] = as.character(strsplit(as.character(tb[i,1]),"\\.")[[1]][1])
		tb[i,2] = as.character(strsplit(as.character(tb[i,2]),"\\.")[[1]][1])

}

tb <- tb[-which(tb[,1] =="K"),]
tb <- tb[-which(tb[,2] =="K"),]

tb <- tb[-which(tb[,2] =="L"),]
tb <- tb[-which(tb[,1] =="L"),]


boxplot(

tb[intersect(which(tb[,1] == "A"),which(tb[,2] == "A")),3],tb[intersect(which(tb[,1] == "A"),which(tb[,2] != "A")),3],

tb[intersect(which(tb[,1] == "B"),which(tb[,2] == "B")),3],tb[intersect(which(tb[,1] == "B"),which(tb[,2] != "B")),3],

tb[intersect(which(tb[,1] == "C"),which(tb[,2] == "C")),3],tb[intersect(which(tb[,1] == "C"),which(tb[,2] != "C")),3],

tb[intersect(which(tb[,1] == "D"),which(tb[,2] == "D")),3],tb[intersect(which(tb[,1] == "D"),which(tb[,2] != "D")),3],

tb[intersect(which(tb[,1] == "E"),which(tb[,2] == "E")),3],tb[intersect(which(tb[,1] == "E"),which(tb[,2] != "E")),3],

tb[intersect(which(tb[,1] == "F"),which(tb[,2] == "F")),3],tb[intersect(which(tb[,1] == "F"),which(tb[,2] != "F")),3],
tb[intersect(which(tb[,1] == "G"),which(tb[,2] == "G")),3],tb[intersect(which(tb[,1] == "G"),which(tb[,2] != "G")),3],
tb[intersect(which(tb[,1] == "H"),which(tb[,2] == "H")),3],tb[intersect(which(tb[,1] == "H"),which(tb[,2] != "H")),3],
tb[intersect(which(tb[,1] == "I"),which(tb[,2] == "I")),3],tb[intersect(which(tb[,1] == "I"),which(tb[,2] != "I")),3],
tb[intersect(which(tb[,1] == "J"),which(tb[,2] == "J")),3],tb[intersect(which(tb[,1] == "J"),which(tb[,2] != "J")),3],

col=c("blue","gray"),names=c("A-A","A-other","B-B","B-other","C-C","C-other","D-D","D-other","E-E","E-other","F-F","F-other","G-G","G-other","H-H","H-other","I-I","I-other","J-J","J-other"),las=3
)
abline(h = 97,lty="dashed")
