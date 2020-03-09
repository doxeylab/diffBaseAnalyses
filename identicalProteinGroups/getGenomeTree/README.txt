#next, we can now map the presence/absence of TcdA and TcdB sequence clusters/groups onto a tree of NCBI-based C. difficile genomes

#a tree can be found here
#must first modify the output labels to report the genome accession
https://www.ncbi.nlm.nih.gov/genome/tree/535

#this will produce the file "genomeTree.nwk"

#In R, do following:

library(ape)
tree <- read.tree("genomeTree.nwk")
writeLines(tree$tip.label)

#then copy and paste output to tree.tiplabels

#then run following in shell
cat tree.tiplabels | awk -F '/' '{print $3}' | awk -F '.' '{print $1}'

#back in R
#copy this back to tree$tip.label

write.tree(tree,file="genomeTree.corrected.nwk")

