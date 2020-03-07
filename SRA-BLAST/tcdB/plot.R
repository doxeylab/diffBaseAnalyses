library(ggplot2)

tb <- read.table("sra-vs-ncbi.txt",sep=' ',header=T,col.names=c("X1","X2","X3"))

tb[,1] <- as.factor(tb[,1])
tb[,2] <- as.factor(tb[,2])

tb2 <- as.data.frame(tb)

p1 = ggplot(tb2, aes(x=X2, y=X3)) +
     geom_point(aes(fill=X2), size=5, shape=21, colour="grey20",
                position=position_jitter(width=0.2, height=0.00)) +
                                        scale_y_continuous(trans = "reverse")

dev.new()

plot(p1 + theme(legend.position = "none",axis.title.x=element_blank(),axis.title.y=element_blank()))

